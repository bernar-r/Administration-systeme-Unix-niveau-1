#Utilisation de la syntax ${#VAR} aui calcule le nombre de caractere d'une variable (Variable en shell bash)
comptemoica=$1
if [ "$comptemoica" = "" ]; then
	echo ""
else
echo ${#comptemoica}
fi
