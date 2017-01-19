groups $MY_USER > output
cut -d : -f 2 output > output1
sed -i 's/ //' output1
sed -i 's/ /,/g' output1
cat output1
rm out*
