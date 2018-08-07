#!/bin/bash

set -e
set -u
set -o pipefail
shopt -s nullglob

oldpwd="$(pwd)"
src_archive="${oldpwd}/tar-1.30.tar.xz"
src="${oldpwd}/tar-1.30"
dest="${oldpwd}/out-tar-1.30"

test -d "$src" && find "$src" -delete
tar -xvf "$src_archive"

mkdir -p "$dest"

(
	cd "$src"
	(
		export "CC=gcc"
	       	export "CFLAGS=-O0 -g -fsanitize=address"
		export "CXX=clang++"
		export "CXXFLAGS=-O0 -g -fsanitize=address"
		export "LDFLAGS=-lpthread -lasan"
		"$src"/configure \
			"--prefix=${dest}"
		make
		make install
	)
)
