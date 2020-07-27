<#
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#>
cd $deployed.file
Write-Host "Target folder is $deployed.targetPath"

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

Write-Host "Creating folder $targetPath"
Copy-Item * $targetPath -force -recurse -verbose

$BASE_DIR = pwd
$BASE_DIR = "$BASE_DIR\" -replace "\\", "\\"
$files = Get-ChildItem . -recurse | Where-Object {$_.PSIsContainer -eq $False} | % {$_.FullName}
ForEach ( $FILE_NAME in $files ) {
    $SFILE_NAME = $FILE_NAME -replace $BASE_DIR
    $DFILE_NAME = "$targetPath\$SFILE_NAME"
    $deployed.fileProperties.GetEnumerator() | Foreach-Object {
       $myKey   = $_.Key
       $myValue = $_.Value
       Write-Host "$DFILE_NAME set permission $myKey to $myValue"
       $(Get-Item $DFILE_NAME).($myKey)=$myValue 
    }
}
$res=$?
if ( ! $res ) {
  exit $res
}

