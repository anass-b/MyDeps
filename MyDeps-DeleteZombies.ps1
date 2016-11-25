. "Functions.ps1"

$zombies = GetZombies
$vendorDirPath = GetVendorDirFullPath
foreach ($zombie in $zombies) {
    $zombiePath = $vendorDirPath + [System.IO.Path]::DirectorySeparatorChar + $zombie
    try {
        [System.IO.Directory]::Delete($zombiePath, 1)
        Write-Host "Deleted: " $zombiePath -ForegroundColor Green
    }
    catch {
        Write-Host "Could not delete: " $zombiePath -ForegroundColor Red
    }
}