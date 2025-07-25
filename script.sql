CREATE DATABASE stationdb;
USE stationdb;

CREATE TABLE Station (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10),
    rue VARCHAR(100),
    commune VARCHAR(100),
    capacite_gazoline INT,
    capacite_diesel INT,
    quantite_gazoline INT,
    quantite_diesel INT
);

CREATE TABLE approvisionnement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_station INT,
    type_carburant ENUM('gazoline', 'diesel'),
    quantite INT,
    date_livraison DATE,
    fournisseur VARCHAR(100),
    FOREIGN KEY (id_station) REFERENCES station(id)
);

CREATE TABLE Vente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_station INT,
    type_carburant ENUM('gazoline', 'diesel'),
    quantite INT,
    prix_vente DECIMAL(10,2),
    date_vente DATE,
    revenu DECIMAL(10,2),
    FOREIGN KEY (id_station) REFERENCES Station(id)
);

CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_util VARCHAR(50) UNIQUE,
    mot_de_passe VARCHAR(100),
    role VARCHAR(20)
);

-- Insertion dans Station
INSERT INTO Station (numero, rue, commune, capacite_gazoline, capacite_diesel, quantite_gazoline, quantite_diesel) VALUES
('ST001', 'Rue Capois', 'Port-au-Prince', 10000, 8000, 6000, 4000),
('ST002', 'Avenue Christophe', 'Delmas', 12000, 9000, 7000, 5000),
('ST003', 'Rue Panaméricaine', 'Pétion-Ville', 9000, 7000, 5000, 3000),
('ST004', 'Boulevard Toussaint', 'Carrefour', 11000, 8500, 6500, 4500),
('ST005', 'Rue Oswald Durand', 'Léogâne', 8000, 6000, 4000, 2000),
('ST006', 'Avenue Martin Luther', 'Cité Soleil', 9500, 7500, 5000, 3500),
('ST007', 'Rue Monseigneur Guilloux', 'Port-au-Prince', 10500, 8000, 6000, 4000),
('ST008', 'Route de Frères', 'Pétion-Ville', 10000, 9000, 7000, 6000),
('ST009', 'Rue du Centre', 'Jacmel', 8500, 6500, 3000, 2000),
('ST010', 'Route Nationale #1', 'Gonaïves', 9500, 7000, 4500, 3000);

-- Insertion dans Utilisateur
INSERT INTO Utilisateur (nom_util, mot_de_passe, role) VALUES
('admin1', 'pass123', 'admin'),
('user1', 'pass123', 'vendeur'),
('user2', 'pass123', 'vendeur'),
('manager1', 'pass123', 'manager'),
('admin2', 'pass456', 'admin'),
('user3', 'pass456', 'vendeur'),
('user4', 'pass789', 'vendeur'),
('manager2', 'pass789', 'manager'),
('tech1', 'pass321', 'technicien'),
('tech2', 'pass654', 'technicien');

-- Insertion dans approvisionnement
INSERT INTO approvisionnement (id_station, type_carburant, quantite, date_livraison, fournisseur) VALUES
(1, 'gazoline', 2000, '2025-07-01', 'Total Haïti'),
(2, 'diesel', 1500, '2025-07-02', 'National Fuel'),
(3, 'gazoline', 1800, '2025-07-03', 'PetroCaribe'),
(4, 'diesel', 1600, '2025-07-04', 'Total Haïti'),
(5, 'gazoline', 1400, '2025-07-05', 'SOGENER'),
(6, 'diesel', 1700, '2025-07-06', 'Total Haïti'),
(7, 'gazoline', 1900, '2025-07-07', 'National Fuel'),
(8, 'diesel', 2000, '2025-07-08', 'PetroCaribe'),
(9, 'gazoline', 1500, '2025-07-09', 'SOGENER'),
(10, 'diesel', 1800, '2025-07-10', 'Total Haïti');

-- Insertion dans Vente
INSERT INTO Vente (id_station, type_carburant, quantite, prix_vente, date_vente, revenu) VALUES
(1, 'gazoline', 500, 250.00, '2025-07-11', 125000.00),
(2, 'diesel', 600, 200.00, '2025-07-11', 120000.00),
(3, 'gazoline', 550, 240.00, '2025-07-11', 132000.00),
(4, 'diesel', 500, 210.00, '2025-07-11', 105000.00),
(5, 'gazoline', 600, 230.00, '2025-07-11', 138000.00),
(6, 'diesel', 400, 220.00, '2025-07-11', 88000.00),
(7, 'gazoline', 650, 250.00, '2025-07-11', 162500.00),
(8, 'diesel', 700, 215.00, '2025-07-11', 150500.00),
(9, 'gazoline', 480, 235.00, '2025-07-11', 112800.00),
(10, 'diesel', 520, 205.00, '2025-07-11', 106600.00);
