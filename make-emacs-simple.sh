#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

oldpwd="$(pwd)"
src="${oldpwd}/emacs-26.1.tar.xz"
dest="${oldpwd}/out-emacs-26.1"

tar -xvf "$src"

mkdir -p "$dest"

(
	cd "./emacs-26.1"
	(
		export "CANNOT_DUMP=yes"
		export "CC=gcc"
		export "CFLAGS=-00 -g -fsanitize=address"
		export "LDFLAGS=-lpthread -lasan"
		./configure \
			"--prefix=${dest}"
	)
	make
	make install
)
