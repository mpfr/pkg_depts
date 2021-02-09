| :warning: With the release of OpenBSD version 6.9, this branch will reach its end of life and will no longer be maintained.
| --- |

# pkg_depts

Figures out which [OpenBSD](https://www.openbsd.org) packages directly or indirectly depend on the package(s) in question.

> Note: Only installed packages will be considered.

## How to install

Make sure you're running `OpenBSD 6.7-stable`. Otherwise, one of the following branches might be more appropriate:
* [current](https://github.com/mpfr/pkg_depts)
* [6.8-stable](https://github.com/mpfr/pkg_depts/tree/6.8-stable)

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
$ doas rm -rf pkg_depts-6.7-stable/
$ ftp -Vo - https://codeload.github.com/mpfr/pkg_depts/tar.gz/6.7-stable | tar xzvf -
pkg_depts-6.7-stable
pkg_depts-6.7-stable/LICENSE
pkg_depts-6.7-stable/README.md
pkg_depts-6.7-stable/docs
pkg_depts-6.7-stable/docs/mandoc.css
pkg_depts-6.7-stable/docs/pkg_depts.1.html
pkg_depts-6.7-stable/src
pkg_depts-6.7-stable/src/Makefile
pkg_depts-6.7-stable/src/pkg_depts.1
pkg_depts-6.7-stable/src/pkg_depts.sh
```

Install tool and manpage.

```
$ cd pkg_depts-6.7-stable/src
$ doas make install
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-6.7-stable/src/pkg_depts.sh ...
install -c -o root -g bin -m 444  pkg_depts.1 ...
```

Besides on the console, the manpage is also available by pointing your browser to `pkg_depts-6.7-stable/docs/pkg_depts.1.html`.

## How to uninstall

```
$ cd pkg_depts-6.7-stable/src
$ doas make uninstall
rm /usr/local/sbin/pkg_depts /usr/local/man/man1/pkg_depts.1
```
