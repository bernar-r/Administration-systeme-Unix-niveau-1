grep -e "/bin/shells/close" passwd > output
cut -d : -f 1 output
rm output
