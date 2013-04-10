#!/bin/bash
set -ex

# here I keep the dos files
# The unix path is a link to the directory with KCPSM3.EXE and ROM_form.* files in it
DOSPATH="\XASM"
UNIXPATH=~/XASM

FILENAME=$1
cp $FILENAME $UNIXPATH
BN=${FILENAME%.psm}
#FILENAME=${FILENAME%.PSM}
#
#cat > $UNIXPATH/kcpsm3.bat <<EOM
#cd $DOSPATH
#KCPSM3.EXE $BN.psm > KCPSM3.LOG
#exitemu
#EOM

INPUT="\P1;  C:\r cd \\xasm\r kcpsm3 $FILENAME > kcpsm3.log\r exitemu\r"
dosemu -dumb -quiet -input "$INPUT"

mv $UNIXPATH/pass[12345].dat .
mv $UNIXPATH/$BN* .
mv $UNIXPATH/constant*.txt .
mv $UNIXPATH/labels.txt .
mv $UNIXPATH/kcpsm3.log kcpsm3.log

ERR=$(egrep "^ERROR" kcpsm3.log)
if [ "$ERR" != "" ] ; then
	echo "ERRORS : $ERR "
	exit 1 
else
	exit 0
fi
