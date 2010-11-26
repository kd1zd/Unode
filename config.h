#ifndef	CONFIG_H
#define	CONFIG_H

/*
 * Some global #defines for programmers to use for conditional compilation
 */
#define HAVE_AX25	1
#define HAVE_FLEX	1
#undef HAVE_ROSE
#define HAVE_NETROM	1
#define HAVE_ZLIB	1
#define HAVE_MHEARD	1
#define HAVE_TCPIP	1
#define	PROC_AX25_CALLS_FILE	"/proc/net/ax25_calls"

/*
 * mheard specific (we need to get this out of here!!!!)
 */
#define	DATA_MHEARD_FILE	"/usr/local/var/ax25/mheard/mheard.dat"

/*
 * node specific
 */
#define	CONF_NODE_FILE		"/etc/ax25/unode.conf"
#define	CONF_NODE_PERMS_FILE	"/etc/ax25/unode.perms"
#define HAVEMOTD		"/etc/ax25/unode.motd"
#define	CONF_NODE_INFO_FILE	"/etc/ax25/unode.info"
#define	DATA_NODE_LOGIN_FILE	"/var/ax25/node/loggedin"
#define	DATA_NODE_HELP_DIR	"/etc/ax25/help/"
#endif
