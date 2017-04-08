#!/usr/bin/env bash
# simple test harness for coding challenges
# Usage: testharness.sh some_executable input_file_prefix output_file_prefix

#set -o errexit
#set -o pipefail
#set -o nounset

__input_file_prefix=$2
__output_file_prefix=$3

__dir=$(pwd)
__executable_file="${__dir}/$1"
files=$(ls "${__dir}/${__input_file_prefix}"*)
__input_files=($files)
files=$(ls "${__dir}/${__output_file_prefix}"*)
__output_files=($files)

#echo "${__dir}"
#printf '%s\n' "${__input_files[@]}"
#printf '%s\n' "${__output_files[@]}"

for __curr_input_file in "${__input_files[@]}"
do
    __curr_root_n_suffix=$(sed -e "s#.*${__input_file_prefix}\(\)#\1#" <<< "${__curr_input_file}")
    __curr_output_file="${__dir}/${__output_file_prefix}${__curr_root_n_suffix}"
    #echo ${__curr_input_file}
    #echo ${__curr_output_file}

    #./sample.sh < sample_in.1 > tmp.1; diff sample_out.1 tmp.1; echo $?
    eval "${__executable_file}" < ${__curr_input_file} > tmp.1
    __curr_diff=$(diff "${__curr_output_file}" tmp.1)
    __curr_exit_code=$?
    echo "Result for ${__curr_input_file}: ${__curr_exit_code}"
    echo "${__curr_diff}"
    echo ""
done
