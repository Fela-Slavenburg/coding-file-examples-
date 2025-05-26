<?php
require "CraftNetDB.php";

class Projects {
    public $dbh;

    public function __construct() {
        $this->dbh = new CraftNetDBconnection();
    }

    public function query($sql): bool|PDOStatement {
        return $this->dbh->query($sql);
    }

    public function prepare($sql) {
        return $this->dbh->prepare($sql);
    }

    public function projectvoegen($userID, $dienst, $uren, $beschrijving, $datum, $status) {
    
        try {
            $this->dbh->run("INSERT INTO projecten (userID, dienst, uren, beschrijving, datum, status) VALUES (:userID, :dienst, :uren, :beschrijving, :datum, :status)", [
                "userID" => $userID, 
                "dienst" => $dienst, 
                "uren" => $uren, 
                "beschrijving" => $beschrijving, 
                "datum" => $datum, 
                "status" => $status
            ]);
            return true; 
        } catch (Exception $e) {
            return false; 
        }
    }
}
?>