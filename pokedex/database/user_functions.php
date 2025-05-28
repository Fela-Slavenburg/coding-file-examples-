<?php
require "pokedexDB.php";

class Trainer {
    private $dbh;

    public function __construct(pokedex $db) {
        $this->dbh = $db;
    }

    public function registreer($trainername, $email, $telephone, $age, $password) {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        
        try {
            $this->dbh->beginTransaction();
    
            $this->dbh->insert( "trainer", [
                "trainername" => $trainername,
                "email" => $email,
                "telephone" => $telephone,
                "age" => $age,
                "password" => $hash,
            ]);
        
            $this->dbh->commit();
        } catch (Exception $e) {
            $this->dbh->rollBack();
            error_log("Error during regisstration: " . $e->getMessage());
        }
    }
    
    public function login($trainername, $password) {
        $stmt = $this->dbh->execute("SELECT * FROM trainer WHERE trainername = :trainername LIMIT 1", [":trainername" => $trainername]);
        $stmt->execute([':trainername' => $trainername]);
    
        $trainer  = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($trainer && password_verify($password, $trainer['password'])) {
            return $trainer;
        }
        return false;
    }
    public function getTrainerByName($trainername) {
        $sql = "SELECT id, trainername FROM trainers WHERE trainername = :trainername";
        $stmt = $this->dbh->getPDO()->prepare($sql);
        $stmt->bindParam(':trainername', $trainername, PDO::PARAM_STR);
        $stmt->execute();
    
        return $stmt->fetch(PDO::FETCH_ASSOC); 
    }
}