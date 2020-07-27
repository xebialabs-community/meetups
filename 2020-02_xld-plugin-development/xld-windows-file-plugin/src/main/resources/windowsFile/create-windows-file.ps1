<#
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#>


$targetPath = $deployed.targetPath
if ( (Test-Path $targetPath) -eq $false ) {
  Write-Host "Creating target path $targetPath"
  if ( $deployed.createTargetPath ) {
     if ( $deployed.createTargetPath ) {
         mkdir $targetPath
     }
     $res=$?
     if ( ! $res ) {
       Write-Host "Problem making directory $targetPath"
       exit $res
     }
   }
} else {
  Write-Host "Target path $targetPath already exists"
}

if ( $deployed.targetFileName ) {
    Write-Host "Setting TARGET_FILE_NAME to $deployed.targetFileName"
    $TARGET_FILE_NAME=$deployed.targetFileName
} else {
    Write-Host "Setting TARGET_FILE_NAME to deployed.name"
    $TARGET_FILE_NAME=$deployed.name
}

$TARGET_FILE="$targetPath\$TARGET_FILE_NAME"
Write-Host "Creating $TARGET_FILE"
Copy-Item -force $deployed.file $TARGET_FILE -verbose
$deployed.fileProperties.GetEnumerator() | Foreach-Object {
   $myKey   = $_.Key
   $myValue = $_.Value
   Write-Host "$TARGET_FILE set permission $myKey to $myValue"
   $(Get-Item $TARGET_FILE).($myKey)=$myValue 
}
$res=$?
if ( ! $res ) {
  Write-Host "Problem copying $deployed.file to $TARGET_FILE"
  exit $res
}

