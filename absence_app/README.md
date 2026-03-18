# 🎓 GestiAbsence — Application Intelligente de Gestion des Absences
## PFE — Génie Informatique 2ème Année

---

## 📋 Technologies utilisées

| Composant        | Technologie                        |
|------------------|------------------------------------|
| Langage          | Python 3.10+                       |
| Framework        | Django 4.2                         |
| Base de données  | MySQL (via XAMPP)                  |
| Interface        | HTML5 + CSS3 + Bootstrap 5.3       |
| QR Code          | qrcode (Python)                    |
| Graphiques       | Chart.js 4                         |
| Éditeur          | Visual Studio Code                 |
| Environnement    | Anaconda / Jupyter (optionnel)     |

---

## 🚀 Guide d'installation étape par étape

### Étape 1 — Prérequis

1. **XAMPP** installé et MySQL démarré (port 3306)
2. **Python 3.10+** installé (ou Anaconda)
3. **Visual Studio Code** (recommandé)

---

### Étape 2 — Créer la base de données MySQL

1. Ouvrir **phpMyAdmin** : http://localhost/phpmyadmin
2. Cliquer sur **"Nouvelle base de données"**
3. Nom : `absence_db`, Encodage : `utf8mb4_unicode_ci`
4. Cliquer **Créer**

OU exécuter dans MySQL CLI :
```sql
CREATE DATABASE absence_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

---

### Étape 3 — Installer les dépendances Python

```bash
# Ouvrir un terminal dans le dossier du projet
cd absence_app

# Créer et activer l'environnement virtuel (recommandé)
python -m venv venv

# Windows
venv\Scripts\activate

# Mac/Linux
source venv/bin/activate

# Installer les packages
pip install -r requirements.txt
```

> ⚠️ Si `mysqlclient` échoue sous Windows, utiliser :
> ```bash
> pip install PyMySQL
> ```
> Et ajouter dans `absence_app/__init__.py` :
> ```python
> import pymysql
> pymysql.install_as_MySQLdb()
> ```

---

### Étape 4 — Configurer la base de données

Vérifier dans `absence_app/settings.py` :
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'absence_db',
        'USER': 'root',
        'PASSWORD': '',        # Votre mot de passe MySQL (vide par défaut sur XAMPP)
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```

---

### Étape 5 — Créer les tables (migrations)

```bash
python manage.py makemigrations accounts
python manage.py makemigrations attendance
python manage.py makemigrations notifications
python manage.py makemigrations dashboard
python manage.py migrate
```

---

### Étape 6 — Charger les données de test

```bash
python manage.py shell < database/init_data.py
```

---

### Étape 7 — Créer les fichiers statiques

```bash
python manage.py collectstatic
```

---

### Étape 8 — Lancer le serveur

```bash
python manage.py runserver
```

Ouvrir : **http://127.0.0.1:8000/**

---

## 👤 Comptes de test

| Rôle           | Identifiant | Mot de passe |
|----------------|-------------|--------------|
| Administrateur | `admin`     | `admin123`   |
| Enseignant 1   | `prof1`     | `prof123`    |
| Enseignant 2   | `prof2`     | `prof123`    |
| Étudiant 1     | `etud1`     | `etud123`    |
| Étudiant 2     | `etud2`     | `etud123`    |
| Étudiant 3     | `etud3`     | `etud123`    |

---

## 🗂️ Structure du projet

```
absence_app/
├── absence_app/           # Configuration Django
│   ├── settings.py        # Paramètres (DB, apps, etc.)
│   ├── urls.py            # URLs principales
│   └── wsgi.py
│
├── accounts/              # App : Utilisateurs & Auth
│   ├── models.py          # User, StudentProfile, TeacherProfile
│   ├── views.py           # Login, Register, Reset password
│   ├── forms.py           # Formulaires d'authentification
│   └── urls.py
│
├── attendance/            # App : Présences & QR Code
│   ├── models.py          # Module, Session, Attendance, Justification
│   ├── views.py           # Vues enseignant / étudiant / admin
│   ├── forms.py           # Formulaires de séance et justification
│   └── urls.py
│
├── dashboard/             # App : Tableaux de bord & IA
│   ├── views.py           # Dashboards + moteur prédictif
│   └── urls.py
│
├── notifications/         # App : Notifications temps réel
│   ├── models.py
│   ├── views.py
│   └── urls.py
│
├── templates/             # Templates HTML
│   ├── base.html          # Template de base avec sidebar
│   ├── accounts/          # Login, Register, Profile
│   ├── dashboard/         # Tableaux de bord (admin/prof/étudiant)
│   ├── teacher/           # Interface enseignant
│   ├── student/           # Interface étudiant
│   ├── admin_panel/       # Interface administrateur
│   └── notifications/
│
├── static/                # Fichiers statiques
├── media/                 # Uploads (QR codes, justificatifs)
├── database/              # Scripts SQL et données initiales
│   ├── create_db.sql
│   └── init_data.py
│
├── requirements.txt       # Dépendances Python
└── manage.py
```

---

## ✨ Fonctionnalités par rôle

### 🛡️ Administrateur
- Tableau de bord avec statistiques globales
- Consulter toutes les absences (par étudiant, module, période)
- Approuver ou rejeter les justifications avec commentaire
- Voir les étudiants à risque (taux > 30%)
- Accès à l'analyse IA globale (répartition des risques)
- Gestion complète via interface Django Admin

### 👨‍🏫 Enseignant
- Créer et gérer ses modules
- Créer des séances (Cours / TD / TP / Examen)
- Générer un QR Code par séance (durée paramétrable)
- Activer / désactiver le QR Code en temps réel
- Marquer les présences manuellement (AJAX)
- Voir le taux d'absence par module et par étudiant
- Tableau de bord hebdomadaire avec graphiques

### 🎓 Étudiant
- Scanner le QR Code pour marquer sa présence
- Voir son historique complet de présences
- Consulter son taux d'absence par module
- Soumettre une justification avec document
- Recevoir des alertes intelligentes (IA)
- Prédictions : risque de dépassement du seuil

---

## 🤖 Module Intelligence Artificielle

Le moteur IA de GestiAbsence inclut :

1. **Détection de tendance** — Compare les 2 dernières semaines pour détecter si les absences augmentent, diminuent ou stagnent

2. **Alertes préventives** — Notifie l'étudiant dès qu'il atteint 30% d'absences

3. **Alerte critique** — Alerte rouge au-delà de 50% (risque d'exclusion)

4. **Prédiction finale** — Calcule le taux d'absence prévu en fin de semestre selon la tendance actuelle

5. **Recommandations personnalisées** — Conseille l'étudiant sur le nombre d'absences restantes autorisées

6. **Vue risque admin** — Doughnut chart de répartition faible/moyen/élevé avec recommandations automatiques

---

## ⚠️ Dépannage courant

| Problème | Solution |
|----------|----------|
| `django.db.utils.OperationalError` | Vérifier que XAMPP MySQL est démarré |
| `ModuleNotFoundError: qrcode` | `pip install qrcode[pil]` |
| `mysqlclient` installation fail | Utiliser PyMySQL (voir étape 3) |
| QR Code ne génère pas | Vérifier que le dossier `media/qrcodes/` existe |
| Images non affichées | Vérifier `MEDIA_URL` et `MEDIA_ROOT` dans settings.py |

---

## 📧 Contact

Projet PFE — Génie Informatique  
Encadrant : [Nom de l'encadrant]  
Étudiant : [Votre nom]  
Année universitaire : 2023-2024
