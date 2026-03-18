-- ============================================================
--  GestiAbsence — Script SQL complet pour MySQL (XAMPP)
--  À exécuter dans phpMyAdmin ou MySQL CLI
-- ============================================================

-- 1. Créer la base de données
CREATE DATABASE IF NOT EXISTS absence_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE absence_db;

-- ============================================================
-- NOTE: Les tables Django seront créées automatiquement par
-- `python manage.py migrate`. Ce script crée uniquement la BD.
-- Les données de test sont insérées ci-dessous via un fixture.
-- ============================================================

-- Vérification
SELECT 'Base de données absence_db créée avec succès !' AS message;
