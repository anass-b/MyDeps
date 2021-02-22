# MyDeps - Very simple dependency manager based on Git, created originally to serve as a C++ dependency manager.

# Usage
Simply clone this project somewhere and add it to your path.
When not running within powershell, the scripts can be run like: `powershell MyDeps-Install.ps1`

# Scripts
## `MyDeps-Install`

Looks for a `mydeps.txt` file in the current folder, then 
reads the repositores mentioned in it and clones them in a `.mydeps` folder
that will be created in the home directory of the current user.

## `MyDeps-Zombies`
Tells which deps/folders are not mentioned in `mydeps.txt` but are present in `vendor` folder.
The primary purpose of this script is to help keep the vendor folder clean and save disk space.

## `MyDeps-DeleteZombies`
The same like `MyDeps-Zombies`, except that it deletes the folders.

## Example `mydeps.txt` file
```
git@bitbucket.org:anassb/project1.git;MyProject1;my-branch
git@github.com:anass-b/project2.git;MyProject2;master
```
