# pkg_depts

Figures out which [OpenBSD](https://www.openbsd.org) packages directly or indirectly depend on the package(s) in question.

For further information, please have a look at the [manpage](https://mpfr.net/man/pkg_depts/7.1-stable/pkg_depts.1.html).

> Note: Only installed packages are considered.

## How to install

First of all, make sure you're running `OpenBSD 7.1-stable`. Otherwise, one of the following branches might be more appropriate:
* [current](https://github.com/mpfr/pkg_depts)
* [7.2-stable](https://github.com/mpfr/pkg_depts/tree/7.2-stable)

Then, make sure your user (e.g. `mpfr`) has sufficient `doas` permissions.

```
$ cat /etc/doas.conf
permit nopass mpfr
```

Download and extract the source files into the user's home directory, here `/home/mpfr`.

```
$ cd
$ pwd
/home/mpfr
$ doas rm -rf pkg_depts-7.1-stable/
$ ftp -Vo - https://codeload.github.com/mpfr/pkg_depts/tar.gz/7.1-stable | tar xzvf -
pkg_depts-7.1-stable
pkg_depts-7.1-stable/LICENSE
pkg_depts-7.1-stable/README.md
pkg_depts-7.1-stable/docs
pkg_depts-7.1-stable/docs/pkg_depts.1.html
pkg_depts-7.1-stable/src
pkg_depts-7.1-stable/src/Makefile
pkg_depts-7.1-stable/src/pkg_depts.1
pkg_depts-7.1-stable/src/pkg_depts.sh
pkg_depts-7.1-stable/src/pkg_info_1.pl
```

Install tool and manpage.

```
$ cd pkg_depts-7.1-stable/src
$ doas make install
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-7.1-stable/src/pkg_depts.sh ...
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-7.1-stable/src/pkg_info_1...
install -c -o root -g bin -m 444  pkg_depts.1 ...
```

## How to uninstall

```
$ cd ~/pkg_depts-7.1-stable/src
$ doas make uninstall
rm /usr/local/sbin/pkg_depts /usr/local/sbin/pkg_info_1 /usr/local/man/man1/...
```
