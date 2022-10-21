# pkg_depts

Figures out which [OpenBSD](https://www.openbsd.org) packages directly or indirectly depend on the package(s) in question.

For further information, please have a look at the [manpage](https://mpfr.net/man/pkg_depts/current/pkg_depts.1.html).

> Note: Only installed packages are considered.

## How to install

First of all, make sure you're running `OpenBSD-current`. Otherwise, one of the following branches might be more appropriate:
* [7.2-stable](https://github.com/mpfr/pkg_depts/tree/7.2-stable)
* [7.1-stable](https://github.com/mpfr/pkg_depts/tree/7.1-stable)

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
$ doas rm -rf pkg_depts-current/
$ ftp -Vo - https://codeload.github.com/mpfr/pkg_depts/tar.gz/current | tar xzvf -
pkg_depts-current
pkg_depts-current/LICENSE
pkg_depts-current/README.md
pkg_depts-current/docs
pkg_depts-current/docs/pkg_depts.1.html
pkg_depts-current/src
pkg_depts-current/src/Makefile
pkg_depts-current/src/pkg_depts.1
pkg_depts-current/src/pkg_depts.sh
pkg_depts-current/src/pkg_info_1.pl
```

Install tool and manpage.

```
$ cd pkg_depts-current/src
$ doas make install
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-current/src/pkg_depts.sh ...
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-current/src/pkg_info_1...
install -c -o root -g bin -m 444  pkg_depts.1 ...
```

## How to uninstall

```
$ cd ~/pkg_depts-current/src
$ doas make uninstall
rm /usr/local/sbin/pkg_depts /usr/local/sbin/pkg_info_1 /usr/local/man/man1/...
```
