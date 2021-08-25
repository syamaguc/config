FILE_PATH=$HOME/Dropbox/vimwiki/todo.md

printf "============ TODO ==============\n"

grep "\- \[[\ ]" $FILE_PATH | sed 's/^[ \t]*//' | sed 's/\[ \]/[0%]/g'
grep "\- \[[.]"  $FILE_PATH | sed 's/^[ \t]*//' | sed 's/\[.\]/[20%]/g'
grep "\- \[[o]"  $FILE_PATH | sed 's/^[ \t]*//' | sed 's/\[o\]/[50%]/g'
grep "\- \[[O]"  $FILE_PATH | sed 's/^[ \t]*//' | sed 's/\[O\]/[80%]/g'
grep "\- \[[X]"  $FILE_PATH | sed 's/^[ \t]*//' | sed 's/\[X\]/✔/g'
