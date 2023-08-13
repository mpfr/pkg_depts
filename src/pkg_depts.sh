#!/bin/ksh
#
# Copyright (c) 2020 - 2023 Matthias Pressfreund
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

vrex='\-[0-9]+(\.[0-9]+)*(p[0-9]+)?(v[0-9]+)?$'

get_name()
{
	echo $1 | sed -E "s/${vrex}//" | sed "s/[.*?]/\\\&/g"
}

get_version()
{
	echo $1 | egrep -o "${vrex}"
}

min_package()
{
	echo $1 | egrep -o "^.*\-[0-9]+(\.[0-9]+){0,${MINORS}}"
}

find_dependents()
{
	local _name=$(get_name $1) _version=$(get_version $1) _pkg _dep
	[[ -n ${_version} ]] || _version='\-[0-9]+'
	echo ${cache} | egrep " ${_name}${_version}" | \
		while read -r _pkg _dep; do
			printf "%${indent}s%s <- %s\n" '' ${_dep} ${_pkg}
			_pkg=$(min_package ${_pkg})
			_dep=$(min_package ${_dep})
			if [[ ${known#*${_pkg} ${_dep}} = ${known} ]]; then
				known="${known}${_pkg} ${_dep}\n"
				indent=$((indent+4))
				find_dependents ${_pkg}
			fi
		done
	indent=$((indent-4))
}

pkg_info()
{
	pkg_info_1 $@ 2>/dev/null
}

TREE=false
while getopts m:t arg; do
	case ${arg} in
	m)	MINORS=$OPTARG;;
	t)	TREE=true;;
	*)	echo "usage: ${0##*/} [-m <number>] [-t] [pkg-name ...]" >&2
		exit 1;;
	esac
done
shift $((OPTIND-1))

[[ -n ${MINORS} ]] || MINORS=0
if ! echo "${MINORS}" | grep -qE '^[0-9]+$'; then
	echo "${0##*/}: invalid parameter" >&2
	exit 1
fi

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
