function GetVendorDirFullPath() {
    $path = (Get-Item -Path ".\" -Verbose).FullName + [System.IO.Path]::DirectorySeparatorChar + "vendor"
    return $path
}

function MyDepsDirFullPath() {
    $path = $env:USERPROFILE + [System.IO.Path]::DirectorySeparatorChar + ".mydeps"
    return $path
}

function GetDepsFileFullPath() {
    $path = (Get-Item -Path ".\" -Verbose).FullName + [System.IO.Path]::DirectorySeparatorChar + "mydeps.txt"
    return $path
}

function CreateDirIfNotExist($dir) {
    if (-Not (Test-Path $dir)) {
        New-Item -ItemType directory -Path $dir | Out-Null
    }
}

# Build an array $deps that holds all deps mentioned in Deps.txt file
function ReadDepsOrExit() {
    $depsFilePath = GetDepsFileFullPath
    if (-Not (Test-Path $depsFilePath)) {
	    Write-Host "mydeps.txt file not found"
	    exit
    }
    $reader = [System.IO.File]::OpenText($depsFilePath)
    $deps = New-Object System.Collections.Generic.List[System.Object] 
    $count = 1
    for() {
	    $line = $reader.ReadLine()
	    if ($line -eq $null) { break }
	    $row = $line.Split(';')
        if ($row.Count -lt 2) {
            Write-Host "Line number $count is invalid: $line" -ForegroundColor Red
            exit
        }
	    $deps.Add($row)
        $count++
    }
    $reader.Close()
    return $deps.ToArray()
}

function ReadDepsNamesOrExit() {
    $deps = ReadDepsOrExit
    $depsNames = New-Object System.Collections.Generic.List[System.Object] 
    foreach ($row in $deps) {
        $depsNames.Add($row[1])
    }
    return $depsNames.ToArray()
}

# Calculate the diff between $deps and $vendor to find out which dependencies
# are present in vendor folder but are not mentioned in Deps.txt files
function GetZombies() {
    $deps = ReadDepsNamesOrExit
    $vendor = ReadVendorDir
    $diff = Compare-Object -ReferenceObject $deps  -DifferenceObject $vendor -PassThru
    return $diff
}

# Get the content of vendor folder into an array
function ReadVendorDir() {
    return Get-ChildItem "vendor"
}

function RunCommand ($cmd) {
    Write-Host $cmd
    Invoke-Expression $cmd
}

function PrintArrayWithNewLines($arr) {
    foreach ($item in $arr) {
        Write-Host $item
    }
}