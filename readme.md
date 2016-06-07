# apt-cyg in powershell

## Why Do I Want To Use apt-cyg in powershell

Well, if you are a fan of Cygwin, you probably don't need this, just use Cygwin.

On the other hand if you are a fan of powershell, like me, 
you can have the continent of apt-cyg together with tons of great functionality that powershell provides.

Or there are some program require dependency on cygwin (like [clion](https://www.jetbrains.com/clion/)),
Then you can install all the required package of cygwin without actually jumping into cygwin

## install

You can use 

```
choco install apt-cyg
```

pretty soon

## How is this different from `cyg-get` or just `cygwinsetup.exe`

[cyg-get](https://chocolatey.org/packages/cyg-get) is actually a wrapper of `cygwinsetup.exe`, 
so every time you will see a popup windows that show you a package is installing. 
(even if `cyg-get` let `cygwinsetup.exe` run in quiet mode)

1.`cyg-get` and `cygwinsetup.exe` do not generate useful command line output:

when `cyg-get` is run without admin right
```
> cyg-get.bat gdb

Attempting to install cygwin packages: gdb
note: Hand installation over to elevated child process.
```

when `cyg-get` is run with admin right:
```
PS C:\Users\zcsxo> cyg-get gdb

Attempting to install cygwin packages: gdb
Starting cygwin install, version 2.874
User has backup/restore rights
Current Directory: C:\cygwin64\packages
Could not open service McShield for query, start and stop. McAfee may not be installed, or we don't have access.
root: C:\cygwin64 system
Selected local directory: C:\cygwin64\packages
net: Direct
site: http://mirrors.kernel.org/sourceware/cygwin/
Changing gid back to original
running: C:\cygwin64\bin\dash.exe "/etc/postinstall/0p_000_autorebase.dash"
running: C:\cygwin64\bin\dash.exe "/etc/postinstall/0p_update-info-dir.dash"
Changing gid to Administrators
Ending cygwin install
```

while... it seems like installing cygwin...
so There is no indication of whether this package is successful or not.

But,
apt-cyg running with admin right (It will throw an error if you run this without admin's right):
```
PS C:\Users\zcsxo> apt-cyg install gdb

Package gdb is already installed, skipping

PS C:\Users\zcsxo> apt-cyg remove gdb

Removing gdb
Package gdb removed

PS C:\Users\zcsxo> apt-cyg install gdb

Installing gdb
gdb-7.10.1-1.tar.xz: OK
Unpacking...
Package gdb requires the following packages, installing:
cygwin libexpat1 libiconv2 libintl8 liblzma5 libncursesw10 libreadline7 python
Package cygwin is already installed, skipping
Package libexpat1 is already installed, skipping
Package libiconv2 is already installed, skipping
Package libintl8 is already installed, skipping
Package liblzma5 is already installed, skipping
Package libncursesw10 is already installed, skipping
Package libreadline7 is already installed, skipping
Package python is already installed, skipping
Package gdb installed
```

2.`cyg-get` do not support remove and list 

But `apt-cyg` in powershell supports all the feature [`apt-cyg`](https://github.com/transcode-open/apt-cyg) supports.

Which is:

```
install
  Install package(s).

remove
  Remove package(s) from the system.

update
  Download a fresh copy of the master package list (setup.ini) from the
  server defined in setup.rc.

download
  Retrieve package(s) from the server, but do not install/upgrade anything.

show
  Display information on given package(s).

depends
  Produce a dependency tree for a package.

rdepends
  Produce a tree of packages that depend on the named package.

list
  Search each locally-installed package for names that match regexp. If no
  package names are provided in the command line, all installed packages will
  be queried.

listall
  This will search each package in the master package list (setup.ini) for
  names that match regexp.

category
  Display all packages that are members of a named category.

listfiles
  List all files owned by a given package. Multiple packages can be specified
  on the command line.

search
  Search for downloaded packages that own the specified file(s). The path can
  be relative or absolute, and one or more files can be specified.

searchall
  Search cygwin.com to retrieve file information about packages. The provided
  target is considered to be a filename and searchall will return the
  package(s) which contain this file.
```

## how do this work

This is actually a wrapper around `apt-cyg`, basically we just install `apt-cyg` and send every command to `apt-cyg`


