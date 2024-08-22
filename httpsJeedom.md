# Freebox side
Needs to request "full stack" access from assistance.free.fr
After that you will be able to redirect ports 80 and 443 to jeedom RPi

So restart Freebox after about 30 min after "full stack" request
Redirect port 80 to 80 of Jeedom and the same for 443

# Install certbot (lets encrypt)
To have all configured ssl access (requested for Alexa access) install certbot and itt will handle ssl certificat for you

## Install Certbot
Il est important de comprendre que lorsque vous générez votre certificat, celui-ci est créé sur votre Raspberry PI et pour votre nom de domaine. Commencez donc à vous connecter à votre Raspberry PI en SSH.

Installez ensuite snapd via les commandes suivantes :

```bash
sudo apt update
sudo apt install snapd
```
Redémarrez ensuite Jeedom pour vous assurez que les chemins de snap soient corrects.

Après cela, assurez-vous que la version de snapd soit à jour :
```bash
sudo snap install core
sudo snap refresh core
```
Supprimez ensuite certbot-auto s’il est installé (notamment pour ceux qui utilisaient certbot-auto pour générer leur certificat) :
```bash
sudo apt-get remove certbot
```
Si vous obtenez un message vous indiquant que certbot-auto, n’insistez pas et passez à l’étape suivante.

Installez ensuite Certbot :
```bash
sudo snap install --classic certbot
```
Vérifiez le bon fonctionnement de Certbot avec la commande suivante :
```bash
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```
Installer votre certificat en éditant automatiquement la configuration d’Apache pour l’utiliser :
```bash
sudo certbot --apache
```
