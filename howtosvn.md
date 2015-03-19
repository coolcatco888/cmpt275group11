# How to SVN using Bash #

This details how you can work using svn.  This applies to commands using bash or command-line in windows.  There are equivalent commands using tortoise.

## Checking out Source Code ##

Open up the Terminal or in windows cmd.exe

```
svn checkout https://cmpt275group11.googlecode.com/svn/trunk/ cmpt275group11 --username [your google username here]
```

## Working using SVN ##

After checking out a working copy from svn, use the bash terminal to navigate to where you checked out the repository.

**Step 1: Updating your repository**

When you first start your work, you must update your working copy (project source code stored locally on your hard drive). This can be done by opening the terminal and navigating to your working copy.

```
svn up
```

**Step 2: Commiting your stuff**

So you've added files and modified them.  Now you want to check in your work so that others have it too.  You must make sure the project builds before checking in.  First update (shown above) if there are no modifications, great.  Otherwise do another build to make sure it still builds with the changes.  Once that is done you make check the status of your modified files.

```
svn st
```

the terminal may display something like this:
```
? project/src/newfile.h
M project/src/modifiedfile.h
```

the entry with the "?" means that you created a new file, this file must be added before checking in. Do this by typing:

```
svn add project/src/newfile.h
```

You must do this with every file unless you have tortoise, which can add many files at a time.

Check the status once again to verify that this has been added. Now commit.

```
svn ci -m "Your commit message here, make it meaningful so we can submit the commit logs for our project documentation"
```

once finished check the svn status again to see that it has been done.