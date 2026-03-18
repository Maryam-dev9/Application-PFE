#!/bin/bash
echo "===================================================="
echo "   GestiAbsence - Installation automatique"
echo "   PFE Genie Informatique 2024"
echo "===================================================="
echo

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "[ERREUR] Python 3 non trouvé. Installez Python 3.10+"
    exit 1
fi

echo "[1/5] Installation des dépendances..."
pip install -r requirements.txt

echo
echo "[2/5] Création des migrations..."
python manage.py makemigrations accounts
python manage.py makemigrations attendance
python manage.py makemigrations notifications
python manage.py makemigrations

echo
echo "[3/5] Application des migrations..."
python manage.py migrate

echo
echo "[4/5] Chargement des données de test..."
python manage.py shell < database/init_data.py

echo
echo "[5/5] Fichiers statiques..."
python manage.py collectstatic --noinput

echo
echo "===================================================="
echo "   Installation terminée!"
echo "   Lancer: python manage.py runserver"
echo "   Ouvrir: http://127.0.0.1:8000/"
echo "===================================================="
