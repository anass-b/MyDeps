# This script shows deps that are not mentioned in Deps.txt but are present in vendor folder
# The primary purpose of this script is to help keep the vendor folder clean and save disk space

. "Functions.ps1"

$zombies = GetZombies
if ($zombies.Count -gt 0) {
    PrintArrayWithNewLines $zombies
}