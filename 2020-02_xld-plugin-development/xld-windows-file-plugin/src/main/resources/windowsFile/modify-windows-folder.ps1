<#
THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#>

# do not remove - this actually triggers the upload
if ( $deployed.file -ne $null ) {
   cd $deployed.file
}

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

$files = Get-ChildItem . -recurse | Where-Object {$_.PSIsContainer -eq $True} | % {$_.FullName}
$BASE_DIR = pwd
$BASE_DIR = "$BASE_DIR\" -replace "\\", "\\"
ForEach ( $DIR_NAME in $files ) {
    $DIR_NAME = $DIR_NAME -replace $BASE_DIR
    if ( (Test-Path "$targetPath\$DIR_NAME") -eq $false ) {
         Write-Host "Make subdirectory $targetPAth\$DIR_NAME"
         mkdir "$targetPath\$DIR_NAME"
    }
}
$files = Get-ChildItem . -recurse | Where-Object {$_.PSIsContainer -eq $False} | % {$_.FullName}
ForEach ( $FILE_NAME in $files ) {
    $SFILE_NAME = $FILE_NAME -replace $BASE_DIR
    $DFILE_NAME = "$targetPath\$SFILE_NAME"
    if ( (Test-Path $DFILE_NAME) -eq $true ) {
         $SCKSUM = (Get-FileHash $SFILE_NAME -Algorithm MD5).Hash
         $DCKSUM = (Get-FileHash $DFILE_NAME -Algorithm MD5).Hash
         if ( "$DCKSUM" -ne "$SCKSUM" ) {
            Write-Host "Copy $SFILE_NAME to $DFILE_NAME ( $SCKSUM / $DCKSUM )"
            Copy-Item $SFILE_NAME $DFILE_NAME
            $deployed.fileProperties.GetEnumerator() | Foreach-Object {
               $myKey   = $_.Key
               $myValue = $_.Value
               Write-Host "$DFILE_NAME set permission $myKey to $myValue"
               $(Get-Item $DFILE_NAME).($myKey)=$myValue 
            }
         }
    } else {
         Write-Host "Copy $SFILE_NAME to $DFILE_NAME"
         New-Item -ItemType File -Path $DFILE_NAME
         Copy-Item $SFILE_NAME $DFILE_NAME
         $deployed.fileProperties.GetEnumerator() | Foreach-Object {
            $myKey   = $_.Key
            $myValue = $_.Value
            Write-Host "$DFILE_NAME set permission $myKey to $myValue"
            $(Get-Item $DFILE_NAME).($myKey)=$myValue 
         }
    }
}
$res=$?
if ( ! $res ) {
  exit $res
}

