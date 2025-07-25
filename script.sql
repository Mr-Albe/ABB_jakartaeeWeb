
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
    id_fournisseur VARCHAR(100),
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

-- Donnee de test
INSERT INTO Station (numero, rue, commune, capacite_gazoline, capacite_diesel, quantite_gazoline, quantite_diesel)
VALUES 
('ST001', 'Rue A', 'Delmas', 10000, 8000, 5000, 4000),
('ST002', 'Rue B', 'Petion-Ville', 9000, 7000, 4500, 3000),
('ST003', 'Rue C', 'Carrefour', 11000, 9000, 6000, 5000),
('ST004', 'Rue D', 'Delmas', 9500, 8500, 4700, 4200),
('ST005', 'Rue E', 'Croix-des-Bouquets', 12000, 10000, 7000, 6000),
('ST006', 'Rue F', 'Tabarre', 10000, 8000, 5000, 4000),
('ST007', 'Rue G', 'Delmas', 9500, 8500, 4700, 4200),
('ST008', 'Rue H', 'Gressier', 11000, 9000, 6000, 5000),
('ST009', 'Rue I', 'Léogâne', 10000, 8000, 5000, 4000),
('ST010', 'Rue J', 'Port-au-Prince', 9000, 7000, 4500, 3000),
('ST011', 'Rue K', 'Delmas', 11000, 9000, 6000, 5000),
('ST012', 'Rue L', 'Pétion-Ville', 10000, 8000, 5000, 4000),
('ST013', 'Rue M', 'Carrefour', 9500, 8500, 4700, 4200),
('ST014', 'Rue N', 'Delmas', 12000, 10000, 7000, 6000),
('ST015', 'Rue O', 'Tabarre', 10000, 8000, 5000, 4000),
('ST016', 'Rue P', 'Delmas', 9500, 8500, 4700, 4200),
('ST017', 'Rue Q', 'Gressier', 11000, 9000, 6000, 5000),
('ST018', 'Rue R', 'Léogâne', 10000, 8000, 5000, 4000),
('ST019', 'Rue S', 'Port-au-Prince', 9000, 7000, 4500, 3000),
('ST020', 'Rue T', 'Delmas', 11000, 9000, 6000, 5000);

INSERT INTO approvisionnement (id_station, type_carburant, quantite, date_livraison, id_fournisseur)
VALUES
(1, 'gazoline', 1000, '2025-07-01', 'FOUR001'),
(2, 'diesel', 800, '2025-07-02', 'FOUR002'),
(3, 'gazoline', 1200, '2025-07-03', 'FOUR003'),
(4, 'diesel', 700, '2025-07-04', 'FOUR001'),
(5, 'gazoline', 900, '2025-07-05', 'FOUR002'),
(6, 'diesel', 950, '2025-07-06', 'FOUR003'),
(7, 'gazoline', 1100, '2025-07-07', 'FOUR001'),
(8, 'diesel', 750, '2025-07-08', 'FOUR002'),
(9, 'gazoline', 1000, '2025-07-09', 'FOUR003'),
(10, 'diesel', 800, '2025-07-10', 'FOUR001'),
(11, 'gazoline', 1200, '2025-07-11', 'FOUR002'),
(12, 'diesel', 700, '2025-07-12', 'FOUR003'),
(13, 'gazoline', 900, '2025-07-13', 'FOUR001'),
(14, 'diesel', 950, '2025-07-14', 'FOUR002'),
(15, 'gazoline', 1100, '2025-07-15', 'FOUR003'),
(16, 'diesel', 750, '2025-07-16', 'FOUR001'),
(17, 'gazoline', 1000, '2025-07-17', 'FOUR002'),
(18, 'diesel', 800, '2025-07-18', 'FOUR003'),
(19, 'gazoline', 1200, '2025-07-19', 'FOUR001'),
(20, 'diesel', 700, '2025-07-20', 'FOUR002');


INSERT INTO Vente (id_station, type_carburant, quantite, prix_vente, date_vente, revenu)
VALUES
(1, 'gazoline', 500, 250.00, '2025-07-01', 125000),
(2, 'diesel', 400, 230.00, '2025-07-02', 92000),
(3, 'gazoline', 600, 260.00, '2025-07-03', 156000),
(4, 'diesel', 350, 240.00, '2025-07-04', 84000),
(5, 'gazoline', 450, 255.00, '2025-07-05', 114750),
(6, 'diesel', 470, 235.00, '2025-07-06', 110450),
(7, 'gazoline', 550, 260.00, '2025-07-07', 143000),
(8, 'diesel', 380, 240.00, '2025-07-08', 91200),
(9, 'gazoline', 500, 250.00, '2025-07-09', 125000),
(10, 'diesel', 400, 230.00, '2025-07-10', 92000),
(11, 'gazoline', 600, 260.00, '2025-07-11', 156000),
(12, 'diesel', 350, 240.00, '2025-07-12', 84000),
(13, 'gazoline', 450, 255.00, '2025-07-13', 114750),
(14, 'diesel', 470, 235.00, '2025-07-14', 110450),
(15, 'gazoline', 550, 260.00, '2025-07-15', 143000),
(16, 'diesel', 380, 240.00, '2025-07-16', 91200),
(17, 'gazoline', 500, 250.00, '2025-07-17', 125000),
(18, 'diesel', 400, 230.00, '2025-07-18', 92000),
(19, 'gazoline', 600, 260.00, '2025-07-19', 156000),
(20, 'diesel', 350, 240.00, '2025-07-20', 84000);


