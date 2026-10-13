#!/bin/bash

# Chargement de la configuration
CONFIG_FILE="$(dirname "$0")/../config/toolkit.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Erreur : fichier de configuration introuvable ($CONFIG_FILE)" >&2
    exit 1
fi

# Préparation du répertoire de rapport
mkdir -p "$REPORTS_DIR"
RAPPORT="$REPORTS_DIR/system-monitor.log"

# Construction du rapport
{
    echo "======================================"
    echo " Surveillance Système - $SERVER_NAME"
    echo " Date : $(date '+%Y-%m-%d %H:%M:%S')"
    echo "======================================"
    echo ""
    echo "--- Mémoire ---"
    free -h 2>/dev/null || echo "free non disponible sur cet environnement"
    echo ""
    echo "--- Espace Disque ---"
    df -h /
    echo ""
    echo "--- Charge Système ---"
    uptime 2>/dev/null || echo "uptime non disponible sur cet environnement"
    echo "======================================"
} | tee "$RAPPORT"

echo "Rapport généré avec succès dans : $RAPPORT"