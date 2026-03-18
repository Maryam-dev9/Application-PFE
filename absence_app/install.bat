@echo off
echo ====================================================
echo    GestiAbsence - Installation automatique
echo    PFE Genie Informatique 2024
echo ====================================================
echo.

REM Check Python
python --version 2>nul
if %errorlevel% neq 0 (
    echo [ERREUR] Python n'est pas installe. Veuillez installer Python 3.10+
    pause
    exit /b 1
)

echo [1/5] Installation des dependances...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERREUR] Echec installation dependances
    pause
    exit /b 1
)

echo.
echo [2/5] Creation des migrations...
python manage.py makemigrations accounts
python manage.py makemigrations attendance
python manage.py makemigrations notifications
python manage.py makemigrations

echo.
echo [3/5] Application des migrations...
python manage.py migrate
if %errorlevel% neq 0 (
    echo [ERREUR] Echec des migrations. Verifiez que MySQL/XAMPP est demarre.
    pause
    exit /b 1
)

echo.
echo [4/5] Chargement des donnees de test...
python manage.py shell < database/init_data.py

echo.
echo [5/5] Collection des fichiers statiques...
python manage.py collectstatic --noinput

echo.
echo ====================================================
echo    Installation terminee avec succes!
echo ====================================================
echo.
echo    Lancer le serveur : python manage.py runserver
echo    Ouvrir            : http://127.0.0.1:8000/
echo.
pause
