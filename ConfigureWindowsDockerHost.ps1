#Requires -Version 3.0

<#
.DESCRIPTION
    Configure Docker on Windows Server 2016 Technical Preview 3 with Containers to work with Visual Studio 2015 Tools for Docker.

.EXAMPLE
    & '.\ConfigureWindowsDockerHost.ps1'
#>

function OpenPorts {
    [cmdletbinding()]
    param()
    process {
        # For ASP.NET 5 web application
        netsh advfirewall firewall add rule name="Http 80" dir=in action=allow protocol=TCP localport=80

        # For Docker daemon
        netsh advfirewall firewall add rule name="Docker Secure Port" dir=in action=allow protocol=TCP localport=2376
    }
}

function DecryptProtectedSettings {
    [cmdletbinding()]
    param()
    process {
        [System.Reflection.Assembly]::LoadWithPartialName("System.Security") | Out-Null
        
        # Find the settings file
        $sessionId = [System.IO.Path]::GetFileName($PSScriptRoot)
        $settingsFile = Resolve-Path (Join-Path $PSScriptRoot "..\..\RuntimeSettings\$sessionId.settings")

        # Retrieve cert and encrypted settings information from the settings file
        $settingsContent = [System.IO.File]::ReadAllText($settingsFile)
        $settingsJson = ConvertFrom-Json $settingsContent
        $certThumbprint = $settingsJson.runtimeSettings.handlerSettings.protectedSettingsCertThumbprint
        $protectedSettings = $settingsJson.runtimeSettings.handlerSettings.protectedSettings
        $encryptedSettings = [System.Convert]::FromBase64String($protectedSettings)

        # Find the cert from local certificate store
        $cert = Get-ChildItem Cert:\LocalMachine\My\$certThumbprint    
        $certs = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection($cert)
        
        # Decrypt the protected settings
        $env = New-Object Security.Cryptography.Pkcs.EnvelopedCms 
        $env.Decode($encryptedSettings)
        $env.Decrypt($certs)
        $decryptedBytes = $env.ContentInfo.Content
        $decryptedSettings = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)

        # Return as Json object
        ConvertFrom-Json $decryptedSettings
    }
}

function SaveDockerCertificates {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        $protectedSettingsJson,
        
        [Parameter(Mandatory = $true, Position = 1)]
        $directory
    )
    process {
        if (-Not (Test-Path $directory)) {
            New-Item $directory -type directory
        }
        
        SaveBase64EncodedCertificateToFile $protectedSettingsJson.certs.ca (Join-Path $directory "ca.pem")
        SaveBase64EncodedCertificateToFile $protectedSettingsJson.certs.cert (Join-Path $directory "server-cert.pem")
        SaveBase64EncodedCertificateToFile $protectedSettingsJson.certs.key (Join-Path $directory "server-key.pem")
    }
}

function SaveBase64EncodedCertificateToFile {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        $base64EncodedContent,
        
        [Parameter(Mandatory = $true, Position = 1)]
        $targetFilePath
    )
    process {
        $bytes = [System.Convert]::FromBase64String($base64EncodedContent)
        $contents = [System.Text.Encoding]::UTF8.GetString($bytes)
        [System.IO.File]::WriteAllText($targetFilePath, $contents)
    }
}

# Open Docker required ports
OpenPorts

# Save all required Docker certificates
DecryptProtectedSettings | SaveDockerCertificates -directory "$env:ProgramData\docker\certs.d"

# Restart Docker service to consume the certificates
Restart-Service Docker
