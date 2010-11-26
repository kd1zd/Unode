all: nodeusers unode flexd

CC = gcc
LD = gcc
CFLAGS = -Wstrict-prototypes -O2 -I/usr/local/include -g
LDFLAGS =
LIBS = -lax25 -lax25io

include Makefile.include

COMMON_SRC =		user.c util.c
NODE_SRC =		node.c cmdparse.c config.c command.c mheard.c axcalluser.c \
			gateway.c extcmd.c procinfo.c router.c system.c sysinfo.c ipc.c
NODEUSERS_SRC =		nodeusers.c
FLEXD_SRC = 		flexd.c procinfo.c
 
COMMON_OBJS =		$(COMMON_SRC:.c=.o)
NODE_OBJS =		$(NODE_SRC:.c=.o)
NODEUSERS_OBJS =	$(NODEUSERS_SRC:.c=.o)
FLEXD_OBJS =		$(FLEXD_SRC:.c=.o)

.c.o:
	$(CC) $(CFLAGS) -c $<

install: installbin installman installhelp
	install -m 755    -o root -g root -d		 $(VAR_DIR)
	install -m 755    -o root -g root -d		 $(VAR_DIR)/node
	install -m 644    -o root -g root etc/loggedin	 $(VAR_DIR)/node
	install -m 644    -o root -g root etc/lastlog	 $(VAR_DIR)/node
	install -m 755    -o root -g root -d		 $(VAR_DIR)/flex
	install -m 644    -o root -g root etc/gateways	 $(VAR_DIR)/flex
	
installbin: all
	install -m 4755 -s -o root -g root unode	 $(SBIN_DIR)
	install -m 755  -s -o root -g root nodeusers	 $(SBIN_DIR)
	install -m 755  -s -o root -g root flexd	 $(SBIN_DIR)

installhelp:
	install -m 755    -o root -g root -d		 $(VAR_DIR)
	install -m 755    -o root -g root -d		 $(VAR_DIR)/node/help
	install -m 644    -o root -g root etc/help/*.hlp $(VAR_DIR)/node/help

installconf: installhelp
	install -m 755    -o root -g root -d		 $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.conf  $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.perms $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.info  $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.motd  $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.users $(ETC_DIR)
	install -m 600    -o root -g root etc/unode.routes   $(ETC_DIR)
	install -m 600    -o root -g root etc/flexd.conf  $(ETC_DIR)

installman:
	install -m 644    -o bin -g bin man/nodeusers.1.gz  $(MAN_DIR)/man1
	install -m 644    -o bin -g bin man/uronode.conf.5.gz  $(MAN_DIR)/man5
	install -m 644    -o bin -g bin man/uronode.perms.5.gz $(MAN_DIR)/man5
	install -m 644    -o bin -g bin man/uronode.8.gz       $(MAN_DIR)/man8

upgrade: installman
	install -m 4755 -s -o root -g root uronode       $(SBIN_DIR)
	install -m 4755 -s -o root -g root nodeusers     $(SBIN_DIR)
	install -m 4755 -s -o root -g root flexd	 $(SBIN_DIR)
	install -m 600	-o root -g root	etc/flexd.conf	 $(ETC_DIR)

clean:
	rm -f *.o *~ *.bak *.orig make.debug nodeusers unode flexd
	rm -f etc/*~ etc/*.bak etc/*.orig
	rm -f etc/help/*~ etc/help/*.bak etc/help/*.orig

distclean: clean
	rm -f .depend Makefile.include config.h
	rm -f unode nodeusers flexd
	rm -f Makefile

depend:
	$(CC) $(CFLAGS) -M $(COMMON_SRC) $(NODE_SRC) $(NODEUSERS_SRC) $(FLEXD_SRC) > .depend

unode: $(COMMON_OBJS) $(NODE_OBJS)
	$(LD) $(LDFLAGS) -o unode $(COMMON_OBJS) $(NODE_OBJS) $(LIBS) $(ZLIB)

nodeusers: $(COMMON_OBJS) $(NODEUSERS_OBJS)
	$(LD) $(LDFLAGS) -o nodeusers $(COMMON_OBJS) $(NODEUSERS_OBJS) $(LIBS) $(ZLIB)

flexd: $(FLEXD_OBJS)
	$(LD) $(LDFLAGS) -o flexd $(FLEXD_OBJS) $(LIBS) $(ZLIB)

ifeq (.depend,$(wildcard .depend))
include .depend
endif
