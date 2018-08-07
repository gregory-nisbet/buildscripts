#!/bin/bash

set -e
set -u
set -o pipefail
shopt -s nullglob

oldpwd="$(pwd)"
src_archive="${oldpwd}/Python-3.7.0.tgz"
src="${oldpwd}/Python-3.7.0"
dest="${oldpwd}/out-python-3.7.0"

tar -xvf "$src_archive"

mkdir -p "$dest"

(
	cd "$src"
	(
		export 'CC=clang'
		export 'CFLAGS=-O0 -g'
		export 'CXX=clang++'
		export 'CXXFLAGS=-O0 -g'
		"$src"/configure \
			--prefix="$dest"
	)
	make
	make install
)
