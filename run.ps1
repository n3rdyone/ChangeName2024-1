using namespace System

# Input bindings are passed in via param block.
param($Timer)

# Log current time and process any files in the storage account
Write-Output "PowerShell Timer trigger function ran at: $(Get-Date)"

# Set the storage account details
$storageAccountName = "<your_storage_account_name>"
$storageAccountKey = "<your_storage_account_key>"
$containerName = "<your_container_name>"
$blobName = "file1.txt"
$renamedBlobName = "file1_changed.txt"

# Connect to the storage account
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Check if the file exists
$fileExists = Test-AzStorageBlob -Container $containerName -Blob $blobName -Context $storageContext

if ($fileExists) {
    # Rename the file
    Rename-AzStorageBlob -Container $containerName -Blob $blobName -NewName $renamedBlobName -Context $storageContext
    Write-Output "Renamed file1.txt to file1_changed.txt"
} else {
    Write-Output "file1.txt does not exist"
}
