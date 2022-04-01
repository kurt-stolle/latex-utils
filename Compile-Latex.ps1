param (
    [Parameter(Mandatory=$true)][string]$Path,
    [string]$RootFile="root.tex",
    [string]$Image="latex-utils:latest"
)

# Strict mode
Set-StrictMode -Version Latest

# Exit on error
$ErrorActionPreference = "Stop"

# Resolve path
$Path = Resolve-Path -Path $Path

# Check if the project path exists
if (-Not (Test-Path -Path $Path)) {
    Throw "Path not found: $Path"
}
$rootFilePath = Join-Path -Path $Path -ChildPath $RootFile
if (-Not (Test-Path -Path $rootFilePath)) {
    Throw "Root file not found: $rootFilePath"
}

# Check if the image exists
$imageIDs = (docker images -q "$Image") | Out-String
$imageIDs = $imageIDs.Trim()

if (-Not $imageIDs) {
    Throw "Image not found: $Image"
}

# Compile using Docker
$mount = "type=bind,src={0},dst=/var/tex" -f $Path
Write-Host "Compiling via Docker: $Path"

docker run --rm --mount $mount $Image $RootFile $args