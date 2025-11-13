#!/bin/bash

# usage message
usage() {
    echo "usage: disk_usage.sh [-a -n N] directory..."
    exit 1
}

# default values
include_files=false
top_n=10

# parse options
while getopts ":an:" opt; do
    case $opt in
        a)
            include_files=true
            ;;
        n)
            # if -n has an argument
            if [[ $OPTARG =~ ^[0-9]+$ ]]; then
                top_n=$OPTARG
            else
                usage
            fi
            ;;
        :)
            # if -n given but no number
            if [ "$OPTARG" = "n" ]; then
                top_n=10
            else
                usage
            fi
            ;;
        \?)
            usage
            ;;
    esac
done

shift $((OPTIND - 1))

# at least one directory must be given
if [ $# -lt 1 ]; then
    usage
fi

# main loop: process each directory
for dir in "$@"; do
    if [ ! -d "$dir" ]; then
        echo "error: $dir is not a directory" >&2
        continue
    fi

    if $include_files; then
        # include files and directories
        du -ah "$dir" 2>/dev/null | sort -hr | head -n "$top_n"
    else
        # directories only
        du -h --max-depth=1 "$dir" 2>/dev/null | sort -hr | head -n "$top_n"
    fi
done
