-- Création de la base
CREATE DATABASE IF NOT EXISTS stationdb;
USE stationdb;

-- Supprimer les tables pour les mis a jour
DROP TABLE approvisionnement;
DROP TABLE vente;
DROP TABLE station;

-- Table station
CREATE TABLE station (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    rue VARCHAR(100),
    commune VARCHAR(100),
    capacite_gazoline INT,
    capacite_diesel INT,
    quantite_gazoline INT,
    quantite_diesel INT
);

-- Table approvisionnement
CREATE TABLE approvisionnement ( 
   id INT AUTO_INCREMENT PRIMARY KEY,
    num_station VARCHAR(10) NOT NULL,
    type_carburant ENUM('gazoline', 'diesel'),
    quantite INT,
    date_livraison DATE,
    fournisseur VARCHAR(100),
    FOREIGN KEY (num_station) REFERENCES station(numero)
);


-- Table vente
CREATE TABLE vente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    num_station VARCHAR(10) NOT NULL,
    type_carburant ENUM('gazoline', 'diesel'),
    quantite INT,
    prix_vente DECIMAL(10,2),
    date_vente DATE,
    revenu DECIMAL(10,2),
    FOREIGN KEY (num_station) REFERENCES station(numero)
);

-- Table users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(70) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user'
);

-- Insertion des stations
INSERT INTO station (
    numero, rue, commune, capacite_gazoline, capacite_diesel, quantite_gazoline, quantite_diesel
) VALUES
-- Cap-Haïtien
('ST001', 'Rue 5', 'Cap-Haïtien', 10000, 8000, 6000, 4000),
('ST002', 'Avenue 20', 'Cap-Haïtien', 12000, 9000, 7000, 5000),
('ST003', 'Rue Antoine Simon', 'Cap-Haïtien', 9000, 7000, 5000, 3000),

-- Limonade
('ST004', 'Route Nationale #6', 'Limonade', 11000, 8500, 6500, 4500),
('ST005', 'Rue Marché Public', 'Limonade', 8000, 6000, 4000, 2000),
('ST006', 'Avenue des Étudiants', 'Limonade', 9500, 7500, 5000, 3500),

-- Terrier-Rouge
('ST007', 'Rue Principale', 'Terrier-Rouge', 10500, 8000, 6000, 4000),
('ST008', 'Rue du Collège', 'Terrier-Rouge', 10000, 9000, 7000, 6000),

-- Fort-Liberté
('ST009', 'Rue de la Douane', 'Fort-Liberté', 8500, 6500, 3000, 2000),
('ST010', 'Avenue de la Mer', 'Fort-Liberté', 9500, 7000, 4500, 3000);

-- Insertion des approvisionnements
INSERT INTO approvisionnement (num_station, type_carburant, quantite, date_livraison, fournisseur) VALUES
('ST001', 'gazoline', 2000, '2025-07-01', 'Total Haïti'),
('ST002', 'diesel', 1500, '2025-07-02', 'National Fuel'),
('ST003', 'gazoline', 1800, '2025-07-03', 'PetroCaribe'),
('ST004', 'diesel', 1600, '2025-07-04', 'Total Haïti'),
('ST005', 'gazoline', 1400, '2025-07-05', 'SOGENER'),
('ST006', 'diesel', 1700, '2025-07-06', 'Total Haïti'),
('ST007', 'gazoline', 1900, '2025-07-07', 'National Fuel'),
('ST008', 'diesel', 2000, '2025-07-08', 'PetroCaribe'),
('ST009', 'gazoline', 1500, '2025-07-09', 'SOGENER'),
('ST010', 'diesel', 1800, '2025-07-10', 'Total Haïti');

-- Insertion des ventes
INSERT INTO vente (num_station, type_carburant, quantite, prix_vente, date_vente, revenu) VALUES
('ST001', 'gazoline', 500, 250.00, '2025-07-11', 125000.00),
('ST002', 'diesel', 600, 200.00, '2025-07-11', 120000.00),
('ST003', 'gazoline', 550, 240.00, '2025-07-11', 132000.00),
('ST004', 'diesel', 500, 210.00, '2025-07-11', 105000.00),
('ST005', 'gazoline', 600, 230.00, '2025-07-11', 138000.00),
('ST006', 'diesel', 400, 220.00, '2025-07-11', 88000.00),
('ST007', 'gazoline', 650, 250.00, '2025-07-11', 162500.00),
('ST008', 'diesel', 700, 215.00, '2025-07-11', 150500.00),
('ST009', 'gazoline', 480, 235.00, '2025-07-11', 112800.00),
('ST010', 'diesel', 520, 205.00, '2025-07-11', 106600.00);

-- Insertion des utilisateurs
INSERT INTO users (username, password, role) VALUES
('Jaures', 'password', 'admin'),
('Bendy', 'password', 'admin'),
('Albe', 'password', 'admin'),
('Blemy', 'password', 'admin');
