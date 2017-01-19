mkdir test0
touch -t 201210040000 test0
touch -t 201210040000 test1
mkdir test2
touch -t 201210040000 test2
touch -t 201210040000 test3
touch -t 201210040000 test4
touch -t 201210040000 test5
ln -s testJour01 test6
touch -t 201210040000 testJour01
touch -h -t 201210040000 test6
echo 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' > testJour01
echo '' > test5
echo 'a' > test4
echo '' > test3
echo 'aaa' > test1
touch -t 201210040000 testJour01
touch -h -t 201210040000 test6
touch -t 201210040000 test2
touch -t 201210040000 test3
touch -t 201210040000 test4
touch -t 201210040000 test5
touch -t 201210040000 test0
touch -t 201210040000 test1
chmod u+rwx,g-rw,g+x,o+rx,o-w test0
chmod u-xw,u+r,g-rw,g+x,o-wx,o+r test1
chmod u+rx,u-w,g-rwx,o+r,o-wx test2
chmod u-wx,u+r,g-rwx,o+r,o-xw test3
chmod u-rwx,g+w,g-rx,o-rwx test4
chmod u-wx,u+r,g-rwx,o-wx,o+r test5
chmod u-x,u+rw,g-rw,g+x,o+rx,o-w testJour01
