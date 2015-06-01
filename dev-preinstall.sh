%pre -p /bin/sh
# if [ -r /proc/mounts ] ; then
#         (while read source mountpoint rest ; do
#                 if [ "$mountpoint" = /dev ] ; then
#                         exit 1
#                 fi
#          done
#          exit 0 ) < /proc/mounts
#         MOUNTED=$?
#         if [ "$MOUNTED" -ne 0 ] ; then
#                 echo $"Cannot install the dev package: mounted devfs detected."
#                 exit $MOUNTED
#         fi
# fi
[ -d /dev ] || /bin/mkdir /dev
/usr/sbin/groupadd -g 19 -r -f floppy > /dev/null 2>/dev/null
/usr/sbin/useradd -c "virtual console memory owner" -u 69 \
        -s /sbin/nologin -r -d /dev vcsa 2> /dev/null
exit 0
