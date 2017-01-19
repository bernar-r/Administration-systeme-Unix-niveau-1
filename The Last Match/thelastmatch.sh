#!/bin/sh

aff_init()
{
    printf "%0.s*" $(seq 1 $nombre_etoile)
    echo ""
    while (($check_input < $user_input))
    do
	user_input=$((user_input - 1))
	count=$(($count + 1))
    done
    user_input=$1
    i=1
    while (($check_input < $user_input))
    do
	sticks[$i]=$(($i*2-1))
	printf "*"
	printf "%0.s " $(seq 1 $count)
	printf $var
	printf "%0.s " $(seq 1 $count)
	echo "*"

	var="|"$var"|"
	count=$((count - 1))
	user_input=$((user_input - 1))
	i=$(($i+1))
    done
    printf "%0.s*" $(seq 1 $nombre_etoile)
}

aff()
{
    line_modif=$2
    nb_sticks=$3
    k=1
    printf "%0.s*" $(seq 1 $nombre_etoile)
    echo ""
    space=$(($(($nombre_etoile-2-$k))/2))
    while (($k <= $1))
    do
	if [ $k -eq $line_modif ]
	then
	    sticks[$k]=$((${sticks[$k]}-$nb_sticks))
	fi
	printf "*"
	printf "%0.s " $(seq 1 $space)
	if [[ ${sticks[$k]} != 0 ]]
	then
	    printf "%0.s|" $(seq 1 ${sticks[$k]})
	fi
	printf "%0.s " $(seq 1 $(($nombre_etoile-2-$(($space+${sticks[$k]})))))
	echo "*"
	k=$(($k+1))
	space=$(($space-1))
    done
    printf "%0.s*" $(seq 1 $nombre_etoile)
    echo ""
}

verif_arg()
{
    regex="^[0-9]+$"
    if [[ $1 =~ $regex ]] && [ $1 -gt 1 ] && [ $1 -le 10 ]
    then
	return 1
    else
	return 0
    fi
}

ai_win()
{
    echo -e "\nMaintenant vous pouvez voir mon réel pouvoir ! Looser"
    return 2
}

player_win()
{
    echo -e "\n-\"Non, comment puis-je perdre contre un humain ?!\"\nIl semblerait que l'IA ai Ragequit."
    return 1
}

player1_win()
{
    echo -e "Le joueur \033[36m1\033[0m a gagné la partie ! Bravo !"
    return 1
}

player2_win()
{
    echo -e "Le joueur \033[36m1\033[0m a gagné la partie ! Bravo !"
    return 1
}

aiPlay()
{
    if [[ $2 == 0 ]]
    then
	isRemove=0
	while (( $isRemove == 0 ))
	do
	    line_ai=$(($RANDOM%$1+1))
	    if [[ ${sticks[$line_ai]} != 0 ]]
	    then
		sticks_ai=$(($RANDOM%${sticks[$line_ai]}+1))
		isRemove=1
	    fi
	done
    else
	if [[ $2 -eq 1 ]] || [[ $2 -eq 2 ]]
	then
	    i=0
	    for m in $(seq 1 ${#sticks[@]})
	    do
		if [[ ${sticks[$m]} != 0 ]]
		then
		    i=$(($i+1))
		    n=$m
		fi
	    done
	    if [[ $i -eq 1 ]]
	    then
		line_ai=$n
		if [[ ${sticks[$n]} -gt 1 ]]
		then
		    sticks_ai=$((${sticks[$n]}-1))
		else
		    sticks_ai=1
		fi
		return
	    else
		isRemove=0
		while (( $isRemove == 0 ))
		do
		    line_ai=$(($RANDOM%$1+1))
		    if [[ ${sticks[$line_ai]} != 0 ]]
		    then
			sticks_ai=$(($RANDOM%${sticks[$line_ai]}+1))
			isRemove=1
		    fi
		done
	    fi
	fi
	if [[ $2 == 2 ]]
	then
	    i=0
	    for q in $(seq 1 ${#sticks[@]})
	    do
		if [[ ${sticks[$q]} != 0 ]]
		then
		    i=$(($i+1))
		    n[$i]=$q
		fi
	    done
	    if [[ $i -eq 2 ]]
	    then
		if [[ ${sticks[${n[1]}]} -eq 1 ]]
		then
		    line_ai=${n[2]}
		    sticks_ai=${sticks[${n[2]}]}
		elif [[ ${sticks[${n[2]}]} -eq 1 ]]
		then
		    line_ai=${n[1]}
		    sticks_ai=${sticks[${n[1]}]}
		else
		    isRemove=0
		    while (( $isRemove == 0 ))
		    do
			line_ai=$(($RANDOM%$1+1))
			if [[ ${sticks[$line_ai]} != 0 ]]
			then
			    sticks_ai=$(($RANDOM%${sticks[$line_ai]}+1))
			    isRemove=1
			fi
		    done
		fi
	    else
		isRemove=0
		while (( $isRemove == 0 ))
		do
		    line_ai=$(($RANDOM%$1+1))
		    if [[ ${sticks[$line_ai]} != 0 ]]
		    then
			sticks_ai=$(($RANDOM%${sticks[$line_ai]}+1))
			isRemove=1
		    fi
		done
	    fi
	fi
	echo -e "\033[33mL'IA enlève \033[34m"$sticks_ai"\033[33m allumette(s) sur la ligne \033[34m"$line_ai"\033[0m."
    fi
}

difficulty()
{
    regex="^[0-9]+$"
    if [[ $1 =~ $regex ]]
    then
	if [[ $1 == 0 || $1 == 1 || $1 == 2 ]]
	then
	    echo "Vous avez choisi la difficulté "$1
	    sleep 1
	    return $1
	else
	    echo -e "Tant pis pour vous, difficulté \033[31mmaximum\033[0m !"
	    sleep 1
	    return 2
	fi
    else
	echo -e "Tant pis pour vous, difficulté \033[31mmaximum\033[0m !"
	sleep 1
	return 2
    fi
}

menu()
{
    echo -e "\n Voulez-vous jouer contre l'IA ?" Repondez par oui ou par non
    read user_choice
    if [ $user_choice == "oui" ]
    then
	return 1
    elif [ $user_choice == "non" ]
    then
	return 0
    else
	menu $1
    fi
}

j2()
{
    isOk=0
    while (($isOk == 0))
    do
	echo -e "\n"
	echo "Tour du joueur 2 : "
	printf "\033[36mLigne\033[0m : "
	read user_line
	regex="^[0-9]+$"
	if [[ $user_line =~ $regex ]] && [ $user_line -gt 0 ] && [ $user_line -le $1 ] && [ ${sticks[$user_line]} -gt 0 ]
	then
	    printf "\033[36mNombre d\'allumette\033[0m : "
	    read user_sticks
	    if [[ $user_sticks =~ $regex ]] && [ $user_sticks -gt 0 ] && [ $user_sticks -le ${sticks[$user_line]} ]
	    then
		echo -e "\033[33mVous enlèvez \033[34m"$user_sticks"\033[33m allumette(s) sur la ligne \033[34m"$user_line"\033[0m."
		isOk=1
		aff $1 $user_line $user_sticks
	    fi
	fi
    done
}

main()
{
    verif_arg $1
    if [ $? -eq 1 ]
    then
	nombre_allumette=$(($1 * $1))
	nombre_etoile=$(($1 + $1 + 3))
	user_input=$1
	check_input=0
	count=0
	game_end=0
	is_end=0
	var="|"
	start=0

	menu $1
	isIa=$?
	if [[ $isIa == 1 ]]
	then
	    echo -e "Votre difficulté : "
	    echo -e "\033[32m- 0 : Facile\033[0m"
	    echo -e "\033[34m- 1 : Moyen\033[0m"
	    echo -e "\033[31m- 2 : Difficile\033[0m"
	    read difficulty
	    difficulty $difficulty
	fi
	aff_init $1
	while (($game_end == 0))
	do
	    echo -e "\n"
	    if [[ $isIa == 1 ]]
	    then
		echo "Votre tour : "
	    else
		echo "Tour du joueur 1 :"
	    fi
	    printf "\033[36mLigne\033[0m : "
	    read user_line
	    regex="^[0-9]+$"
	    if [[ $user_line =~ $regex ]] && [ $user_line -gt 0 ] && [ $user_line -le $1 ] && [ ${sticks[$user_line]} -gt 0 ]
	    then
		printf "\033[36mNombre d\'allumette\033[0m : "
		read user_sticks
		if [[ $user_sticks =~ $regex ]] && [ $user_sticks -gt 0 ] && [ $user_sticks -le ${sticks[$user_line]} ]
		then
		    echo -e "\033[33mVous enlevez \033[34m"$user_sticks"\033[33m allumette(s) sur la ligne \033[34m"$user_line"\033[0m."
		    aff $1 $user_line $user_sticks
		    is_end=1
		    j=1
		    while [[ $j -le $1 ]] && [ $is_end != 0 ]
		    do
			if [ ${sticks[$j]} -gt 0 ]
			then
			    is_end=0
			fi
			j=$(($j+1))
		    done
		    if [ $is_end -eq 0 ]
		    then
			if [[ $isIa == 1 ]]
			then
			    echo -e "\n-\"Mh..."
			    sleep 1
			    echo -e "Je pense que ceci devrait convenir !\""
			    sleep 1
			    aiPlay $1 $difficulty
			    aff $1 $line_ai $sticks_ai
			else
			    j2 $1
			fi
			is_end=1
			m=1
			while [[ $m -le $1 ]] && [ $is_end != 0 ]
			do
			    if [ ${sticks[$m]} -gt 0 ]
			    then
				is_end=0
			    fi
			    m=$(($m+1))
			done
			if [[ $is_end != 0 ]]
			then
			    game_end=1
			    if [[ $isIa == 1 ]]
			    then
				player_win
			    else
				player1_win
			    fi
			fi
		    else
			game_end=1
			if [[ $isIa == 1 ]]
			then
			    ai_win
			else
			    player2_win
			fi
		    fi
		fi
	    fi
	done
	echo -e "Voulez-vous rejouer ? oui ou non(par défaut)"
	read restart
	if [ $restart == "oui" ]
	then
	    isOk=0
	    while (( $isOk == 0 ))
	    do
		echo -e "Veuillez choisir le nombre de ligne : "
		read nb_line
		verif_arg $nb_line
		if [[ $? == 1 ]]
		then
		  isOk=1  
		fi	    
	    done
	    main $nb_line
	elif [ $restart == "non" ]
	then
	    return 0
	else
	    menu $1
	fi
    else
	echo -e "\n\033[31mArgument invalide\033[0m, ce doit être un nombre entre \033[32m2\033[0m(minimum) et \033[32m10\033[0m(maximum)"
    fi
}
main $1
