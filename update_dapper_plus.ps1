$basePath = "C:\THE_PATH_WHERE_THIS_SCRIPT_WILL_RUN"

# Logs the execution of this script
Start-Transcript -path "$basePath\logs.txt"

cd $basePath
$packageName = "Z.Dapper.Plus"

# Get the latest version number
$result = Invoke-RestMethod -Uri 'https://api.nuget.org/v3-flatcontainer/z.dapper.plus/index.json'
$packageVersion = $result.versions[$result.versions.Count -1]

# Download the package with nuget.exe
& $basePath\nuget.exe install $packageName -DirectDownload -NoCache -o $basePath

$packagePath = "$basePath\$packageName.$packageVersion\lib\net6.0\$packageName.dll"
Write-Host "Copyinge $packagePath to $basePath"
# Copy and overwrite the olad Z.Dapper.Plus.dll
Copy-Item -Path $packagePath -Destination "$basePath\$packageName.dll" -Force

Stop-Transcript
