#!/bin/sh
rm -rf /var/lib/rpm/__db*
rpm -v --rebuilddb
