# Soar Website Downloads

This repository holds the binary files available for download at soar.eecs.umich.edu. The repository containing the displayable website content is [here](https://github.com/SoarGroup/SoarGroup.github.io).

## Handling Large Files

Files over 50MB should not be added to the repository directly; if you try to push such a file, you will get a warning message from GitHub, or the push will fail with an error if it is larger than 100MB.

Instead, add the file to the appropriate [release](https://github.com/SoarGroup/website-downloads/releases) (or create a new one), and leave a note in a readme file in the appropriate directory explaining that the file is available in the release. As it is fairly easy to accidentally delete one of these files, it is recommended to keep a backup of the file on puff and elsewhere if convenient (such as OneNote). Video files should also be uploaded to our YouTube channel, @soarcognitivearchitecture2624.

### Why we don't use Git LFS

GitHub does support large file storage through [Git LFS](https://git-lfs.github.com/), but they have a bandwidth limit that is shared across the entire organization. This is very easy to hit, and if it is exceeded then it becomes impossible to pull or push any files in LFS, which is very inconvenient. It's also not possible to serve files from LFS through the website, so we would have to add the files to a release, anyway.
