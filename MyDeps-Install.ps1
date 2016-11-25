. "Functions.ps1"

$deps = ReadDepsOrExit

$dotMyDepsDir = MyDepsDirFullPath
CreateDirIfNotExist $dotMyDepsDir

$vendorDir = GetVendorDirFullPath
CreateDirIfNotExist $vendorDir

# Install dependencies
foreach ($row in $deps) {
    $repoUrl = $row[0]
    $name = $row[1]
    $myDepsDestination = $dotMyDepsDir + [System.IO.Path]::DirectorySeparatorChar + $name    

    # Tells if we printed something in the console output
    # so then we can print an empty line at the end
    $didSometing = $false

    # Clone into .mydeps
    if (-Not (Test-Path $myDepsDestination)) {
        $infoText = "Fetching $name"
        Write-Host $infoText -ForegroundColor Yellow

		if ($row.Count -eq 2) {
			RunCommand "git clone --recursive $repoUrl $myDepsDestination"
		}
		elseif ($row.Count -eq 3) {
			$branch = $row[2]
			RunCommand "git clone --recursive $repoUrl $myDepsDestination -b $branch"
		}
        $didSometing = $true
    }
    # Copy to vendor, ovewriting destination files
    $vendorDestination = "vendor" + [System.IO.Path]::DirectorySeparatorChar + $name
    if (-Not (Test-Path $vendorDestination)) {
        $infoText = "Installing $name"
        Write-Host $infoText -ForegroundColor Yellow

        Copy-Item -Force -Recurse $myDepsDestination -Destination $vendorDestination

        $didSometing = $true
    }

    if ($didSometing) {
        Write-Host ""
    }
}