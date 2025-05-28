<?php

class Pokedex {

    protected $dbh;

    public function __construct($db = 'pokedex', $user="root", $pwd="", $host="localhost") {
        try {
            $this->dbh = new PDO("mysql:host=$host;dbname=$db", $user, $pwd);
            $this->dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Connection failed: ") . $e->getMessage();
        }
    }

    public function execute($sql, $args = null) {
        $stmt = $this->dbh->prepare($sql);
        $stmt->execute($args);
        return $stmt;
    }

    public function insert($table, $data) {
        $columns = implode(", ", array_keys($data));
        $placeholders = ":" . implode(", :", array_keys($data));

        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $this->execute($sql, $data);
        return $this->dbh->lastInsertId();
    }

    public function getPDO() {
        return $this->dbh;
    }

    public function fetch($sql, $args = []) {
        $stmt = $this->execute($sql, $args);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function beginTransaction() {
        return $this->dbh->beginTransaction();
    }

    public function commit() {
        return $this->dbh->commit();
    }

    public function rollBack() {
        return $this->dbh->rollBack();
    }

    public function lastInsertId() {
        return $this->dbh->lastInsertId();
    }
}
?>