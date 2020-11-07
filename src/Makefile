
MAN=		pkg_depts.1

SCRIPT=		pkg_depts

BINDIR?=	/usr/local/sbin
MANDIR?=	/usr/local/man/man

realinstall:
	${INSTALL} ${INSTALL_COPY} -o ${BINOWN} -g ${BINGRP} -m ${BINMODE} \
		${.CURDIR}/${SCRIPT}.sh ${DESTDIR}${BINDIR}/${SCRIPT}

uninstall:
	-rm ${BINDIR}/${SCRIPT} ${MANDIR}/${MAN}

.include <bsd.prog.mk>
