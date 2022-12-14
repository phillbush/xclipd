PROG = xclipd
OBJS = ${PROG:=.o}
SRCS = ${PROG:=.c}
MANS = ${PROG:=.1}

PREFIX ?= /usr/local
MANPREFIX ?= ${PREFIX}/share/man
LOCALINC ?= /usr/local/include
LOCALLIB ?= /usr/local/lib
X11INC ?= /usr/X11R6/include
X11LIB ?= /usr/X11R6/lib

# includes and libs
INCS = -I${LOCALINC} -I${X11INC}
LIBS = -L${LOCALLIB} -L${X11LIB} -lX11 -lXfixes

all: ${PROG}

${PROG}: ${OBJS}
	${CC} -o $@ ${OBJS} ${LIBS} ${LDFLAGS}

.c.o:
	${CC} ${INCS} ${CFLAGS} ${CPPFLAGS} -c $<

README: ${MANS}
	man -l ${MANS} | sed 's/.//g' >README

tags: ${SRCS}
	ctags ${SRCS}

clean:
	rm -f ${OBJS} ${PROG} ${PROG:=.core} tags

install: all
	install -d ${DESTDIR}${PREFIX}/bin
	install -d ${DESTDIR}${MANPREFIX}/man1
	install -m 755 ${PROG} ${DESTDIR}${PREFIX}/bin/${PROG}
	install -m 644 ${MANS} ${DESTDIR}${MANPREFIX}/man1/${MANS}

uninstall:
	rm ${DESTDIR}${PREFIX}/bin/${PROG}
	rm ${DESTDIR}${MANPREFIX}/man1/${MANS}

.PHONY: all tags clean install uninstall
