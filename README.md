# CloneDeps

A PowerShell script that looks for a `Deps.txt` file in the current folder,
reads the repositores mentioned in it and clones them in a `vendor/` folder

This script can be used to a simple language agnostic dependency manager based on git.

## Usage within PowerShell
First clone this repo and add it to your `$PATH`, then:
```
cd myproject
Clone-Deps.ps1
```
Optional (but neccessary most of the time): add the `vendor/` folder to your `.gitignore`

## Example `Deps.txt` file
```
git@bitbucket.org:anassb/project1.git;MyProject1
git@github.com:anass-b/project2.git;MyProject2
```