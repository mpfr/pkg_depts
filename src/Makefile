
MAN=		pkg_depts.1

SCRIPT=		pkg_depts
PKG_INFO=	pkg_info_1

BINDIR?=	/usr/local/sbin
MANDIR?=	/usr/local/man/man

realinstall:
	${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} \
		${.CURDIR}/${SCRIPT}.sh ${DESTDIR}${BINDIR}/${SCRIPT}
	${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} \
		${.CURDIR}/${PKG_INFO}.pl ${DESTDIR}${BINDIR}/${PKG_INFO}

uninstall:
	-rm ${BINDIR}/${SCRIPT} ${BINDIR}/${PKG_INFO} ${MANDIR}1/${MAN}

.include <bsd.prog.mk>
