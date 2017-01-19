# n = ne print pas le resultat de la commande
#2~2 = faire une ligne sur deux a partir de la deuxieme
#head affiche les 10 premieres ligne de passwd
#Tac caT
#rev reverse line charactere
#tr pour eliminer des caracteres
# -d pour supprimer
# -i = modifier le fichier d'origine
# $ = faire correspondre a la derniere ligne 

grep "shells/etna" passwd > output
cut -d : -f 1 output > output1

sed -n 2~2p output1 > output2
rev output2 | sort -r > output4


sed -n "$MY_LINE1,$MY_LINE2 p" output4 > output5

sed -i 's/$/,/' output5
tr -d "\n" < output5 > output6
rev output6 > output7
sed -i 's/,/./' output7
rev output7 > output8
sed -i 's/$/\n/' output8
cat output8

