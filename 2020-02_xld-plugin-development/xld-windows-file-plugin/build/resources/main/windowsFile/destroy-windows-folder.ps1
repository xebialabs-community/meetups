<#
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#>
$deployed = $previousDeployed
if ( $deployed.file -ne $null ) {
   cd $deployed.file
}
$targetPath = $deployed.targetPath

if ( (Test-Path $targetPath) -eq $false ) {
  Write-Host "WARN: $targetPath not found. Nothing to do."
  exit
}
$BASE_DIR = pwd
$BASE_DIR = "$BASE_DIR\" -replace "\\", "\\"
if ( $deployed.targetPathShared ) {
     Write-Host "Deleting from shared path $targetPath"
     $files = Get-ChildItem . -recurse | Where-Object {$_.PSIsContainer -ne $True} | % {$_.FullName}
     ForEach ( $ORIGINAL_FILE in $files ) {
          $ORIGINAL_FILE = $ORIGINAL_FILE -replace $BASE_DIR
          $FILE_TO_DELETE = "$targetPath\$ORIGINAL_FILE"
          Write-Host ">> Deleting file $FILE_TO_DELETE"
          if ( (Test-Path $FILE_TO_DELETE) -eq $true ) {
             Remove-Item $FILE_TO_DELETE -force -recurse -ErrorAction Continue
          }
     }
     $files = Get-ChildItem . -recurse | Where-Object {$_.PSIsContainer -eq $True} | % {$_.FullName}
     ForEach ( $ORIGINAL_FILE in $files ) {
          $ORIGINAL_FILE = $ORIGINAL_FILE -replace $BASE_DIR
          $FILE_TO_DELETE = "$targetPath\$ORIGINAL_FILE"
          Write-Host ">> Deleting directory $FILE_TO_DELETE"
          if ( (Test-Path $FILE_TO_DELETE) -eq $true ) {
          if ( (Get-Item $FILE_TO_DELETE ).GetFiles().count -eq 0 ) { 
               Remove-Item $FILE_TO_DELETE -forc -recurse -ErrorAction Continue
          } else {
               Write-Host "$FILE_TO_DELETE is not empty"
          } }
     }
} else {
     Write-Host "Deleting folder $targetPath"
     if ( (Test-Path $targetPath) -eq $true ) {
          Remove-Item $targetPath -force -recurse -ErrorAction Continue
     }
}
$res=$?
if ( ! $res ) {
  exit $res
}
