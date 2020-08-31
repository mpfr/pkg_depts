# pkg_depts

Figures out which [OpenBSD](https://www.openbsd.org) packages directly or indirectly depend on the package(s) in question.

For more information, just have a look at the [manpage](https://mpfr.github.io/pkg_depts/pkg_depts.1.html).

> Note: Only installed packages will be considered.

## How to install

Make sure your user has sufficient `doas` permissions. To start, `cd` into the user's home directory, here `/home/mpfr`.

```
$ cat /etc/doas.conf
permit nopass mpfr
$ cd
$ pwd
/home/mpfr
$
```

Get the sources downloaded and extracted.

```
$ ftp -o - https://codeload.github.com/mpfr/pkg_depts/tar.gz/master | tar xzvf -
pkg_depts-master
pkg_depts-master/README.md
pkg_depts-master/docs
pkg_depts-master/docs/mandoc.css
pkg_depts-master/docs/pkg_depts.1.html
pkg_depts-master/src
pkg_depts-master/src/Makefile
pkg_depts-master/src/pkg_depts.1
pkg_depts-master/src/pkg_depts.sh
$
```

Install tool and manpage.

```
$ cd pkg_depts-master/src
$ doas make install
install -c -o root -g bin -m 555  /home/mpfr/pkg_depts-master/src/pkg_depts.sh ...
install -c -o root -g bin -m 444  pkg_depts.1 ...
$
```

## How to uninstall

```
$ doas rm /usr/local/man/man1/pkg_depts.1
$ doas rm /usr/local/sbin/pkg_depts
$
```
