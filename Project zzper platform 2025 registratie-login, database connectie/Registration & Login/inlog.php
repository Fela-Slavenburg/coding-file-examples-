<?php
require "../Database connection {functions}/user-functions.php";

if (isset($_SESSION['login_status']) && $_SESSION['login_status'] == true) {
    header("Location: ../Profiel/profiel.html");// Location moet nog worden toegevoegt
}

try {
    if($_SERVER['REQUEST_METHOD'] == 'POST') {
        $users = new Users();
        $email = htmlspecialchars($_POST['email']);
        $password = htmlspecialchars($_POST['password']);

        $userData = $users->login($email);
        if ($userData && password_verify($password, $userData['password'])) {
            session_start();
            $_SESSION['login_status'] = true;
            $_SESSION['userID'] = $userData['userID'];
            header("Location: ../Profiel/profiel.html"); // Location moet nog worden toegevoegt
        } else {
            echo "Ongeldig email of wachtwoord";
            header("inlog.html");
            die();
        }
    }
}catch (Exception $e) {
    echo $e->getMessage();
}

include "inlog.html";
?>