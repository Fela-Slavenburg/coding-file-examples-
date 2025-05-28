<?php
require "../database/user_functions.php";
 
session_start();
 
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db = new pokedex('pokedex');
    $trainer = new Trainer($db);
 
    $trainername = htmlspecialchars($_POST['trainername']);
    $email = filter_var($_POST['email'], FILTER_SANITIZE_EMAIL);
    $telephone = htmlspecialchars($_POST['telephone']);
    $age = htmlspecialchars($_POST['age']);
    $password = htmlspecialchars($_POST['password']);
 
    if ($trainer->registreer($trainername, $email, $telephone, $age, $password)) {
        $trainerData = $trainer->getTrainerByName($trainername);
            $_SESSION['is_logged_in'] = true;
            $_SESSION['trainer_id'] = $trainerData['id']; 
            $_SESSION['trainer_name'] = $trainerData['trainername']; 

            $_SESSION['success'] = "Registratie succesvol! U bent nu ingelogd.";
            header("Location: ../pokemon_collection/pokemon.html");
            exit();
        } else {
            $_SESSION['error'] = "Er is iets misgegaan bij het ophalen van uw gegevens.";
            header("Location: start_page.html");
            exit();
        }
} else {
    header("Location: start_page.html"); 
    exit();
    
}
?>
