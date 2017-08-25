#! /usr/bin/env bash

find . -type f -name '*.sh' -print | xargs grep 'string' # search for a string in the files of this dir
find . -type d -ls # List all directories
# find and replace some text in a file in one line
find . -type f -name "*.json" -print | xargs grep -i 'string' | awk '{print $1}' | sed -e 's#:##g' | xargs -n 1 -I % sed -i.bak -e 's#"string"#"newstring"#g' % && find . -type f -name "*.bak" -exec rm {} \;
find . -type f -perm 600 | ifne echo "executable files found" # find files with certain permission settings
# find files with 600 permission settings across ssh dirs of 3 users in parallel
parallel -j3 -- "find /home/developer/.ssh -type f -perm 600" "find /root/.ssh -type f -perm 600" "find /home/ubuntu/.ssh -type f -perm 600"
egrep '(cal|date)' utils.sh # Find the strings in the file

# Fill some line numbers into a file
for i in {1..10}; do echo $i >> foo; done
for i in {1..10}; do echo `expr 20 - $i` >> bar; done
# Use pee to pipe stdin to multiple files
combine foo or bar | pee 'sort -n | uniq >sorted' 'sort -nr | uniq >reverse_sorted'
# Sort the file numerically and add timestamps to the beginning of each line with sub-second resolution
cat sorted | ts -s "%Y/%m/%d:%H:%M:%.S" | sed -e 's#1970/01#2017/08#g;' | sponge sorted
sort -nr reverse_sorted | ts -s "%Y/%m/%d:%H:%M:%.S" | sed -e 's#1970/01#2017/08#g;' | sponge reverse_sorted
