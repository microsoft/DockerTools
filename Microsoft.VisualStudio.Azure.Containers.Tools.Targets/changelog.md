Changelog for [Microsoft.VisualStudio.Azure.Containers.Tools.Targets](https://www.nuget.org/packages/Microsoft.VisualStudio.Azure.Containers.Tools.Targets/) NuGet package

- 1.7.8
  - (Meta) Added Release Notes field to this NuGet package, linking to this document
  - Change to FIPS-compliant version of SHA256
- 1.7.2
  - For ASP.NET Core apps, if the "UserSecretsId" MSBuild property is set, the appropriate user secrets folder will be volume mapped and available in the container even if SSL is not enabled.
- 1.5.4
  - Visual Studio Debugger (VSDBG) should be properly downloaded when using a system proxy.
  - Volume sharing sometimes stops working or credentials expire. Our tools do their best to detect this and provide a clear error message when possible.
- 1.4.10
  - In most cases the .dockerignore file will show as a linked item under the Dockerfile in Solution Explorer.
- 1.4.2
  - Added support for Alpine and Ubuntu (bionic) debugging (In VS2019 just update base images in your dockerfile – See [here](https://github.com/Microsoft/DockerTools/issues/179#issuecomment-482178661) for VS2017 required steps).
