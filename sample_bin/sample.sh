#!/usr/bin/env bash
# for each (lowercase) letter return its index in the alphabet
# ie. c returns 3

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

# read in the inputs
input_file="${1:-/dev/stdin}"
IFS=" " read -ra inputs "${input_file}"

# iterate over the characters and determine the index in the alphabet
declare -a results=()
for var in "${inputs[@]}"
do
    next_result=$((`ord ${var}` - `ord "a"` + 1))
    results=("${results[@]}" "${next_result}")
done

# output results as a space separated string
echo "${results[@]}"
