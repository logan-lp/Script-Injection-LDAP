# Script-Injection-LDAP
Script qui permet de trouver le contenu du flag du CTF "Injection LDAP 2"

On nous demande de nous authentifier sur une interface web dont on ne connait pas les credentials, et de récupérer ceux ci.  \
Lorsque l'on met un "*" dans chaqu'un des champs, nous sommes autorisés à nous connecter.  \
Le flag est la concaténation du code postal, de l'email et du numéro de téléphone tel que : Flag{33000-matt@flag.local-0610178954}  


L'interface web nous demmande un "nom d'utilisateur", un "code postal", un "email" ainsi qu'un "numéro de téléphone".  \
<img width="376" height="456" alt="image" src="https://github.com/user-attachments/assets/7f43c1eb-f01f-4962-9be6-a335a9bde1d6" />
