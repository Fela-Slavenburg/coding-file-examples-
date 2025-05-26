<?php

class CraftNetDBconnection {

    protected $dbh;

    public function __construct($db = "craftnetdb", $user="root", $pwd="", $host="localhost") {
        try {
            $this->dbh = new PDO("mysql:host=$host;dbname=$db", $user, $pwd);
        } catch (PDOException $e) {
            die("Connection failed: ") . $e->getMessage();
        }
    }

    public function query($sql) {
        return $this->dbh->query($sql);
    }

    public function prepare($sql) {
        return $this->dbh->prepare($sql);
    }

    public function run($sql, $args = null) {
        $stmt = $this->dbh->prepare($sql);
        $stmt->execute($args);
        return $stmt;
    }

}

