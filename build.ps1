$rootDir = $env:APPVEYOR_BUILD_FOLDER
$buildNumber = $env:APPVEYOR_BUILD_NUMBER

$solutionFile = "$rootDir\BoletoNetCore\BoletoNetCore.csproj"
$solutionTest = "$rootDir\BoletoNetCore.Testes\BoletoNetCore.Testes.csproj"
$nuspecPath = "$rootDir\BoletoNetCore\BoletoNetCore.nuspec"
$nupkgPath = "$rootDir\NuGet\"

[xml]$xml = cat $nuspecPath
$xml.package.metadata.version="3.0.1."+"$buildNumber"
$xml.Save($nuspecPath)

<#dotnet test $solutionTest#>
dotnet pack -c Release $solutionFile /p:NuspecFile=$nuspecPath -o $nupkgPath
appveyor PushArtifact $nupkgPath