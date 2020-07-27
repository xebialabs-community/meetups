<#
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#>
$deployed = $previousDeployed
if ( $deployed.targetFileName ) {
     Write-Host "Setting TARGET_FILE_NAME to " $deployed.targetFileName
     $TARGET_FILE_NAME = $deployed.targetFileName
} else {
     Write-Host "Setting TARGET_FILE_NAME to " $deployed.name
     $TARGET_FILE_NAME = $deployed.name
}

$TARGET_PATH = $deployed.targetPath
$TARGET_FILE = $TARGET_PATH + "\" + $TARGET_FILE_NAME

Write-Host "Setting TARGET_FILE to " $TARGET_FILE
if ( (Test-Path $TARGET_FILE ) -eq $false ) {
     Write-Host "WARN: $TARGET_FILE not found. Nothing to do."
  exit
}

Write-Host "Deleting file $TARGET_FILE"
Remove-Item $TARGET_FILE -force -recurse
$res=$?
if ( ! $res ) {
  exit $res
}
