<?php
require "CraftNetDB.php";

class Users {
    private $dbh;

    public function __construct() {
        $this->dbh = new CraftNetDBconnection();
    }

    public function register($email, $password, $user_type, $first_name, $last_name, $phone_number, $region) {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        
        $created_at = date('Y-m-d H:i:s'); 
        $updated_at = $created_at; 
    
        try {
            $this->dbh->run("INSERT INTO users (email, password, user_type, first_name, last_name, phone_number, region, created_at, updated_at) VALUES (:email, :password, :user_type, :first_name, :last_name, :phone_number, :region, :created_at, :updated_at)", [
                "email" => $email,
                "password" => $hash,
                "user_type" => $user_type,
                "first_name" => $first_name,
                "last_name" => $last_name,
                "phone_number" => $phone_number,
                "region" => $region,
                "created_at" => $created_at,
                "updated_at" => $updated_at
            ]);
            return true; 
        } catch (Exception $e) {
            return false; 
        }
    }

    public function login($email) {
        return $this->dbh->run("SELECT * FROM users WHERE email = :email", ["email"=>$email])->fetch();
    }


}
?>