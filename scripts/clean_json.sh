#!/bin/bash
sed 's/\\u00a0/ /g' -i "$@"
sed 's,\\n\\n, ,g' -i "$@"
sed 's,\\n , ,g' -i "$@"
sed 's, \\n, ,g' -i "$@"
sed -e 's/^[ \t]*//' -i "$@"
