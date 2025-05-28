<?php
require_once "pokedexDB.php";

class Pokemon {
    private $dbh;

    public function __construct(pokedex $db) {
        $this->dbh = $db;
    }

    public function selectPokemonGegevens() {
        $sql = "SELECT p.ID, p.picture, p.name 
        FROM pokemon p"; 

        $stmt = $this->dbh->getPDO()->prepare($sql);
        $stmt->execute();
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function selectPokemonGegevensById($id) {
        $sql = "SELECT picture, name, type_1, type_2, abilities, evolution, description
            FROM pokemon
            WHERE id = :ID"; 

        $stmt = $this->dbh->getPDO()->prepare($sql);
        $stmt->bindParam(':ID', $id, PDO::PARAM_INT);
        $stmt->execute();
        
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function selectRegistertPokemon($trainer_id) {
        $sql = "SELECT p.picture, p.name, p.type_1, p.type_2, p.abilities, p.evolution, p.description,
                       t.gender, t.hp, t.attack, t.defense, t.`special attack`, t.`special defense`, t.speed
                FROM trainer_pokemon t
                INNER JOIN pokemon p ON t.pokemon_id = p.ID
                WHERE t.trainerID = :trainer_id";
    
        $stmt = $this->dbh->getPDO()->prepare($sql);
        $stmt->bindParam(':trainer_id', $trainer_id, PDO::PARAM_INT); 
        $stmt->execute();
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC); 
    }
}
?>