<?php
$mysqli = require __DIR__ . "/../Database connection {functions}/CraftNetDB.php";

$token = $_GET["token"];
$token_hash = hash("sha256", $token);

$dbConnection = new CraftNetDBconnection();

$sql = "SELECT * FROM users WHERE reset_token_hash = ?";
$stmt = $dbConnection->run($sql, [$token_hash]); 

$user = $stmt->fetch(PDO::FETCH_ASSOC); 

if ($user === false) {
    die("token not found");
}

if (strtotime($user["reset_token_expires_at"]) <= time()) {
    die("token has expired");
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
</body>
</html>