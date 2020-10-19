#!/bin/ksh
#
# Copyright (c) 2020 Matthias Pressfreund
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

find_dependents()
{
	local _regex=$1
	[[ -n $(echo ${_regex} | egrep '\-[0-9]') ]] || _regex=${_regex}\-[0-9]
	echo ${cache} | egrep " ${_regex}" | while read -r pkg dep; do
		printf "%${indent}s"
		echo "${dep} <- ${pkg}"
		if [[ ${known#*${pkg} ${dep}} = ${known} ]]; then
			known="${known}${pkg} ${dep}\n"
			indent=$((indent+4))
			find_dependents ${pkg}
		fi
	done
	indent=$((indent-4))
}

TREE=false
while getopts t arg; do
	case ${arg} in
	t)	TREE=true;;
	*)	echo "usage: ${0##*/} [-t] [pkg-name ...]" >&2
		exit 1;;
	esac
done
shift $((OPTIND-1))

[[ -t 0 ]] || while read -r line; do
	cache="${cache}${line}\n"
done

[[ -n ${cache} ]] || for pkg in $(pkg_info -Aq); do
	[[ -t 1 ]] || echo -n "${pkg} ... " >&2
	depends=$(pkg_info -f ${pkg} | grep '^@depend' | cut -f 3 -d :)
	for dep in ${depends}; do
		[[ -z $@ ]] \
			&& echo "${pkg} ${dep}" \
			|| cache="${cache}${pkg} ${dep}\n"
	done
	[[ -t 1 ]] || echo 'ok' >&2
done

[[ -n ${cache} ]] || exit 0

for arg do
	indent=0
	if ${TREE}; then
		find_dependents ${arg}
	else
		dep=$(find_dependents ${arg})
		[[ -n ${dep} ]] && deplist="${deplist}${dep}\n"
	fi
done
[[ -n ${deplist} ]] && echo "${deplist%'\n'*}" | while read dep delim pkg; do
	echo ${pkg}
done | sort | uniq
