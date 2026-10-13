#!/bin/bash

# Chargement de la configuration
CONFIG_FILE="$(dirname "$0")/../config/toolkit.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Erreur : fichier de configuration introuvable ($CONFIG_FILE)" >&2
    exit 1
fi

# Contrôle des paramètres
if [ "$#" -eq 0 ]; then
    echo "Usage : $0 <service1> [service2 ...]" >&2
    exit 1
fi

# Préparation du répertoire de rapport
mkdir -p "$REPORTS_DIR"
RAPPORT="$REPORTS_DIR/service-check.log"

{
    echo "======================================"
    echo " Contrôle des Services - $SERVER_NAME"
    echo " Date : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "======================================"

    for SERVICE in "$@"; do
        echo ""
        echo "Vérification du service : $SERVICE"
        if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
            echo "-> État : ACTIF"
        else
            echo "-> État : INACTIF ou INCONNU"
        fi
    done
    echo "======================================"
} | tee "$RAPPORT"

echo "Rapport généré dans : $RAPPORT"