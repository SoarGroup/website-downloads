# Soar Website Downloads

This repository holds the binary files available for download at soar.eecs.umich.edu. The repository containing the displayable website content is [here](https://github.com/SoarGroup/SoarGroup.github.io).

## Handling Large Files

Files over 50MB should not be added to the repository directly; if you try to push such a file, you will get a warning message from GitHub, or the push will fail with an error if it is larger than 100MB. Instead, you should first track the files with [Git LFS](https://git-lfs.com/), which will tell GitHub to store the files in a separate location. Follow instructions on the Git LFS website to install it on your system, and then run `git lfs track <large file here>` for each large file you want to add. Then `git add .gitattributes` and `git add <large file here>`. Finally, commit and push as usual.

Files in LFS are not directly downloadable via a permanent link. To get links that are usable on the website, you must also add the file to the [Large Files](https://github.com/SoarGroup/website-downloads/releases/tag/large_files_do_not_remove_this_tag) release page on GitHub.
