#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

set -e
set -u
set -o pipefail
shopt -s nullglob

oldpwd="$(pwd)"
src_archive="${oldpwd}/pkgsrc.tar.gz"
src="${oldpwd}/pkgsrc"
dest="${oldpwd}/out-pkgsrc"

test -d "$src" && find "$src" -delete
tar -xvf "$src_archive"

mkdir -p "$dest"

(
	cd "$src"
	(
		export 'CC=gcc'
	       	export 'CFLAGS=-O0 -g'
		export 'CXX=clang++'
		export 'CXXFLAGS=-O0 -g'
		(
			cd "$src"/bootstrap
			/bin/bash -x \
				"$src"/bootstrap/bootstrap \
				--unprivileged
		)
	)
)
