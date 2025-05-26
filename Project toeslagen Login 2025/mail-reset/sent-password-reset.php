<?php
require __DIR__ . "/../../Database/db.php";
require __DIR__ . "/mailer.php";

$dbConnection = new DB('BP');
if (!$dbConnection) {
    die("Databaseverbinding mislukt.");
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['reset-email']) && !empty($_POST['reset-email'])) {
        $resetemail = $_POST['reset-email'];
    
        $token = bin2hex(random_bytes(16));
        $token_hash = hash("sha256", $token);
        $expiry = date("Y-m-d H:i:s", time() + 60 * 15);

        $dbConnection = new DB('BP');

        $sql = "UPDATE accounts
                SET reset_token_hash = ?, reset_token_expires_at = ?
                WHERE email = ?";

        $stmt = $dbConnection->execute($sql, [$token_hash, $expiry, $resetemail]);

        if ($stmt->rowCount() > 0) {
            $resetLink = "http://localhost/GitHub/3d_p7_toeslagen_groep2/Project/Login/mail-reset/reset-password.php?token=" . $token;
            
            $mail = createMailer($resetemail, $resetLink);
            if (!$mail) {
                header("Location: ../login.php?message=mailer_error");
                exit();}
            echo "Database bijgewerkt. Token en vervaldatum ingesteld.<br>";
        } else {
            echo "Geen gebruiker gevonden met dat e-mailadres.<br>";
            exit();
        }

        try {
            $mail->send();
            header("Location: ../login.php?message=email_sent");
            exit();
        } catch (Exception $e) {
            header("Location: ../login.php?message=error");
            exit();
        }
    } else {
        header("Location: ../login.php?message=email_not_found");
        exit();
    }
}    

