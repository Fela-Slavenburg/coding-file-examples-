<?php
$mysqli = require __DIR__ . "/../../Database/db.php"; 
$dbConnection = new DB('BP');

$token = $_POST["token"];
$token_hash = hash("sha256", $token);

$sql = "SELECT * FROM accounts WHERE reset_token_hash = ?"; 
$stmt = $dbConnection->execute($sql, [$token_hash]); 

$account = $stmt->fetch(PDO::FETCH_ASSOC); 

if (!isset($_POST["token"]) || empty($_POST["token"])) {
    die("Geen token opgegeven.");
}

if (!isset($_POST["password"]) || empty($_POST["password"]) || 
    !isset($_POST["password_confirmation"]) || empty($_POST["password_confirmation"])) {
    die("Vul alle velden in.");
}

if ($_POST["password"] !== $_POST["password_confirmation"]) {
    die("Wachtwoorden komen niet overeen.");
}

$password_hash = password_hash($_POST["password"], PASSWORD_DEFAULT);

$sql = "UPDATE accounts 
        SET password_hash = ?, 
            reset_token_hash = NULL, 
            reset_token_expires_at = NULL 
        WHERE id = ?";

$dbConnection->execute($sql, [$password_hash, $account["id"]]);

echo "Wachtwoord reset succesvol! Je kan nu inloggen met je nieuwe wachtwoord.";
?>