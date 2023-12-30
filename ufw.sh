#!/bin/bash

# Initialiser un tableau pour les commandes de règle
declare -a rule_commands

# Fonction pour installer UFW si ce n'est pas déjà fait
install_ufw() {
  if ! command -v ufw > /dev/null; then
    echo "UFW n'est pas installé. Installation en cours..."
    sudo apt-get update
    sudo apt-get install -y ufw
  else
    echo "UFW est déjà installé."
  fi
}

# Fonction pour gérer les règles SSH existantes
manage_existing_ssh_rules() {
  local existing_rules
  existing_rules=$(sudo ufw status | grep "22") # On filtre les règles pour le port 22

  if [ -n "$existing_rules" ]; then
    echo "Des règles SSH existent déjà :"
    echo "$existing_rules"
    read -p "Voulez-vous supprimer les règles SSH existantes ? (o/n) " choice

    if [ "$choice" = "o" ]; then
      echo "Suppression des règles SSH..."
      sudo ufw reset
    fi
  fi
}

# Fonction pour ajouter de nouvelles règles SSH
add_ssh_rules() {
  read -p "Combien d'appareils souhaitez-vous autoriser ? " device_count
  read -p "Voulez-vous ajouter des règles par IP ou MAC ? (ip/mac) " type

  for ((i=1; i<=device_count; i++)); do
    if [ "$type" = "ip" ]; then
      read -p "Entrez l'adresse IP de l'appareil $i : " ip_address
      echo "Ajout de la règle pour l'adresse IP: $ip_address"
      rule_commands+=("sudo ufw allow from $ip_address to any port 22")
    else
      echo "UFW ne supporte pas directement les règles basées sur les adresses MAC."
      exit 1
    fi
  done

  # Ajouter la règle pour bloquer toutes les autres connexions SSH
  rule_commands+=("sudo ufw deny 22")

  # Affichage des commandes
  echo "Les commandes suivantes seront exécutées :"
  for cmd in "${rule_commands[@]}"; do
    echo $cmd
  done

  read -p "Voulez-vous exécuter ces commandes ? (o/n) " confirm
  if [ "$confirm" = "o" ]; then
    for cmd in "${rule_commands[@]}"; do
      eval $cmd
    done
    echo "Activation de UFW..."
    sudo ufw --force enable
    echo "État actuel des règles UFW :"
    sudo ufw status verbose
  fi
}

# Execution des fonctions
install_ufw
manage_existing_ssh_rules
add_ssh_rules