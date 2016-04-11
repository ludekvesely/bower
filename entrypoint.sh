#!/bin/bash

if [ "$1" = "bower" ]; then
	BASE_DIR=${TMPDIR:-/var/tmp}
	ORIG_DIR=$PWD
	HASH_CMD="md5sum"
	DIR_NAME=`echo $PWD | $HASH_CMD | cut -f1 -d " "`
	TMP_DIR=$BASE_DIR/$DIR_NAME
	
	mkdir -p $TMP_DIR
	pushd $TMP_DIR >/dev/null

	ln -sf $ORIG_DIR/bower.json
	ln -sf $ORIG_DIR/.bowerrc
fi

"$@"

if [ "$1" = "bower" ]; then
	unlink bower.json
	unlink .bowerrc
	rsync --recursive --links --times . $ORIG_DIR
	popd >/dev/null
fi

