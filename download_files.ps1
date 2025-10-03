# download_files.ps1

# List of files to download
$files = @(
	"NZ24_Whanganui/CL2_BM37_2024_1000_2204.laz",
	"NZ24_Whanganui/CL2_BM37_2024_1000_2205.laz",
	"NZ24_Whanganui/CL2_BM37_2024_1000_2206.laz",
	"NZ24_Whanganui/CL2_BM37_2024_1000_2207.laz",
	"NZ24_Whanganui/CL2_BM37_2024_1000_2208.laz"
)

# Base S3 URL
$s3Base = "s3://pc-bulk/"

# Local download folder
$localFolder = "C:\DATA\000_ Sophie_Rothman\Downloads"

# Ensure local folder exists
if (-not (Test-Path $localFolder)) {
    New-Item -ItemType Directory -Path $localFolder | Out-Null
}

# Endpoint and no-sign-request option
$endpoint = "https://opentopography.s3.sdsc.edu"
$noSign = "--no-sign-request"

# Loop over each file
foreach ($file in $files) {
    $s3Path = "$s3Base$file"
    Write-Host "Downloading $file ..."
    
    aws s3 cp $s3Path $localFolder --endpoint-url $endpoint $noSign
}
