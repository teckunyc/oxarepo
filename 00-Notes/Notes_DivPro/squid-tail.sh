#!/bin/sh
tail -f $1 | gawk '{ printf strftime("%c", $1); for (i=2; i<NF; i++) printf $i " "; print $NF }'
