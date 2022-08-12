Changelog for [Microsoft.VisualStudio.Azure.Containers.Tools.Targets](https://www.nuget.org/packages/Microsoft.VisualStudio.Azure.Containers.Tools.Targets/) NuGet package. This list is not exhaustive; it is curated to include only interesting changes.

## 1.17.0
- Support for SDK Style .NET Framework web projects.

## 1.16.1
- Support for [Worker Service](https://docs.microsoft.com/en-us/dotnet/core/extensions/workers) project
- Expand variables in launchSettings.json. Fixes [issue](https://developercommunity.visualstudio.com/t/Variables-not-expanded-in-DockerfileRunA/1638317)

## 1.15.1
- Fixes an error while building a containerized application.

## 1.15.0
- Improved Azure Functions Core tooling install experience.
- Fixes invalid assembly load failure.

## 1.14.0
- Fixes a VS hang while adding docker support to .NET Framework project.
- Support for Azure Functions .NET 6.0
- Support for the .json version of StaticWebAssets
- Fixes a bug in Azure Functions .NET 5 (Isolated)
- Fixed a bug in handling static assets for .NET 6.0

## 1.11.1
- Add support for isolated Azure Functions (.NET5).
- Fix an issue where docker pull used to fail during warmup if dockerfile had dockerfile ARGs.
- Show custom MSBuild properties in the UI.

## 1.10.8
- Fix issue with inconsistent nuget package and tooling version

## 1.9.10
  - Use dynamic ports instead of explicit ports.
  - Create the container with project name.
  - Support custom `BaseIntermediateOutputPath`.
  - Add support for scaffolding Azure Functions v3 projects.

## 1.9.5
  - Adds support for Blazor ASP.NET Core web apps
    - Also requires Visual Studio 16.3 Preview 3 or later.

## 1.9.2
- Adds support for Azure function container debugging.
  - Also requires Visual Studio 16.3 Preview 2 or later.
  - Currently Linux containers only.

## 1.7.12
- Updates to logic for determining if ports that Docker wants to map are already in use when debugging in VS.

## 1.7.8
- (Meta) Added Release Notes field to this NuGet package, linking to this document.
- Change to FIPS-compliant version of SHA256.

## 1.7.2
- For ASP.NET Core apps, if the "UserSecretsId" MSBuild property is set, the appropriate user secrets folder will be volume mapped and available in the container even if SSL is not enabled.

## 1.5.4
- Visual Studio Debugger (VSDBG) should be properly downloaded when using a system proxy.
- Volume sharing sometimes stops working or credentials expire. Our tools do their best to detect this and provide a clear error message when possible.

## 1.4.10
- In most cases the .dockerignore file will show as a linked item under the Dockerfile in Solution Explorer.

## 1.4.2
- Added support for Alpine and Ubuntu (bionic) debugging (In VS2019 just update base images in your dockerfile – See [here](https://github.com/Microsoft/DockerTools/issues/179#issuecomment-482178661) for VS2017 required steps).
