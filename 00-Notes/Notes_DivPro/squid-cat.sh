#!/bin/bash

while read A B
do
	echo $(date -d@$A) $B
done < $1
