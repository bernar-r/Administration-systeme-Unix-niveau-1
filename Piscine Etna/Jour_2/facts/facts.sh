# la syntaxe 's/CeQueJeVeutRemplacer/TextQuiVaRemplacer/g' 
# g permet de selection tout les hold space
sed 's/etna1/newbee/g' passwd > output.txt
sed 's/prof/gentil/g' output.txt > output2.txt
grep -e 'newbee' -e 'gentil' output2.txt 
rm output.txt
rm output2.txt
