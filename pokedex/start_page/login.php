<?php
require "../database/user_functions.php";

session_start();

if (isset($_SESSION['is_logged_in']) && $_SESSION['is_logged_in'] == true) {
    header('Location: ../pokemon_collection/pokemon.html');
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $db = new pokedex('pokedex', 'root', '', 'localhost');
    $trainer = new Trainer($db);

    try {
        $trainerData = $trainer->login($_POST['trainername'], $_POST['password']);
    if ($trainerData && password_verify($_POST['password'], $trainerData['password'])) {
        $_SESSION['is_logged_in'] = true;

        $_SESSION['trainer_id'] = $trainerData['id']; 
        $_SESSION['trainer_name'] = $trainerData['trainername']; 

        header("Location: ../pokemon_collection/pokemon.html");
        exit();
    } else {
        echo "Verkeerde naam of wachtwoord";
        exit();
    }
    } catch (\Exception $e) {
        echo "Error: " . $e->getMessage();
    }
}
?>