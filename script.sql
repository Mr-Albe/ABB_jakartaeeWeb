
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
    revenu NUMBER,
    FOREIGN KEY (id_station) REFERENCES Station(id)
);

CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_util VARCHAR(50) UNIQUE,
    mot_de_passe VARCHAR(100),
    role VARCHAR(20)
);
