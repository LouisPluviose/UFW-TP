# README pour le script de gestion UFW

Ce script Bash est conçu pour faciliter la configuration de UFW (Uncomplicated Firewall) pour gérer les règles SSH, en particulier pour sécuriser l'accès à un serveur via SSH.

## Fonctionnalités

- **Installation automatique d'UFW**: Vérifie si UFW est installé et l'installe si ce n'est pas le cas.
- **Gestion des règles SSH existantes**: Identifie et propose de supprimer les règles SSH existantes avant d'ajouter de nouvelles.
- **Ajout de règles SSH**: Permet à l'utilisateur d'ajouter des règles SSH pour un nombre spécifique d'appareils en utilisant leurs adresses IP.

## Prérequis

- Une distribution Linux compatible avec `apt-get` pour l'installation de UFW.
- Droits de superutilisateur (sudo) pour installer UFW et manipuler les règles de pare-feu.

## Utilisation

1. **Téléchargez le script**: Clonez ou téléchargez ce script sur votre serveur.
2. **Rendez-le exécutable**:

    ```bash
    chmod +x nom_du_script.sh
    ```

3. **Exécutez le script**:

    ```bash
    ./nom_du_script.sh
    ```

Suivez les instructions à l'écran pour installer UFW, gérer les règles SSH existantes, et ajouter de nouvelles règles.

## Fonctions du script

- `install_ufw`: Installe UFW si ce n'est pas déjà fait.
- `manage_existing_ssh_rules`: Gère les règles SSH existantes, permettant leur suppression.
- `add_ssh_rules`: Ajoute de nouvelles règles SSH selon les adresses IP fournies par l'utilisateur.

## Avertissements

- Assurez-vous de comprendre les implications de la modification des règles de pare-feu. La suppression de règles SSH existantes peut couper l'accès à votre serveur.
- Ce script est prévu pour des systèmes utilisant `apt-get`. Pour d'autres distributions, vous devrez peut-être adapter les commandes d'installation.

## Contribution

Les contributions, suggestions et corrections de bugs sont les bienvenues. Pour contribuer, veuillez soumettre une pull request ou ouvrir un problème.

---

Ce script est fourni tel quel, sans garantie de fonctionnalité. Assurez-vous de tester tout changement dans un environnement sécurisé avant de l'appliquer à un serveur de production.
