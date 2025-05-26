<?php
$mysqli = require __DIR__ . "/../Database connection {functions}/CraftNetDB.php";

// var_dump($_POST);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['reset-email']) && !empty($_POST['reset-email'])) {
        $resetemail = $_POST['reset-email'];


    $token = bin2hex(random_bytes(16));
    $token_hash = hash("sha256", $token);
    $expiry = date("Y-m-d H:i:s", time() + 60 * 15);

    $dbConnection = new CraftNetDBconnection();

    $sql = "UPDATE users
            SET reset_token_hash = ?, reset_token_expires_at = ?
            WHERE email = ?";

    $stmt = $dbConnection->run($sql, [$token_hash, $expiry, $resetemail]);

    if ($stmt->rowCount() > 0) {
        $mail = require __DIR__ . "/mailer.php"; 

        $mail->setFrom("");
        $mail->addAddress($resetemail);
        $mail->Subject = "Password Reset";
        $mail->Body = <<<END
        Click <a href="//localhost/GitHub/zzp-ers-platform/Registration & Login/reset-password.php?token=$token">here</a>
        to reset your password.
    END;

        try {
            $mail->send();
            echo "Message sent, please check your inbox."; 
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer error: {$mail->ErrorInfo}";
        }
    } else {
        echo "Geen gebruiker gevonden met dat e-mailadres.";
    }
        
    echo '<script>alert("Message sent, please check your inbox.")</script';
} else {
    echo "No email provided.";
}
} else {
echo "Invalid request method.";
}
?>