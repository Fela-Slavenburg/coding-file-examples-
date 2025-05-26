<?php
require "../Database connection {functions}/user-functions.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = new Users();
    $succes = $user->register(
        $_POST['email'], $_POST['password'], 
        $_POST['user_type'], 
        $_POST['first_name'], $_POST['last_name'], 
        $_POST['phone_number'], $_POST['region']
    );

    if ($succes) {
        echo "Registration successfully!";
    } else {
        echo "Registration failed. Please try again or check the database connection.";
    }
}


include "register.html";
?>