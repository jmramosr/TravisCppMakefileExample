#!/usr/bin/env bash

# This file is typically sourced by another script.
# if possible, ask for the precise number of processors,
# otherwise take 2 processors as reasonable default; see
# https://docs.travis-ci.com/user/speeding-up-the-build/#Makefile-optimization
if [ -x /usr/bin/getconf ]; then
    NPROCESSORS=$(/usr/bin/getconf _NPROCESSORS_ONLN)
else
    NPROCESSORS=2
fi

if [ $OSTYPE != "cygwin" ]
then
		# "Not cygwin"
	# as of 2017-09-04 Travis CI reports 32 processors, but GCC build
	# crashes if parallelized too much (maybe memory consumption problem),
	# so limit to 8 processors for the time being.
	if [ $NPROCESSORS -gt 8 ] ; then
		echo "$0:Note: Limiting processors to use by make from $NPROCESSORS to 4."
		NPROCESSORS=8
	fi
else
    echo "Using cygwin..." # Preparing to use .exe terminations
fi
