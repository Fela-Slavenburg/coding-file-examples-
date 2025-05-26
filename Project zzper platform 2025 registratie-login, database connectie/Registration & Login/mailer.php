<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . "/vendor/autoload.php";

$mail = new PHPMailer(true);

// $mail->SMTPDebug = SMTP::DEBUG_SERVER; 

try {
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = ""; 
    $mail->Password = "";
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    $mail->setFrom('your-email@gmail.com', 'CraftNet'); 

    $mail->addAddress($resetemail);

    $mail->isHTML(true);
    $mail->Subject = 'Wachtwoord Reset';
    $mail->Body    = 'Klik <a href="https://localhost/reset-password.php?token=your-token">hier</a> om je wachtwoord te resetten.';

    $mail->send();
} catch (Exception $e) {
    echo "De e-mail kon niet worden verzonden. Mailer Error: {$mail->ErrorInfo}";
}

$mail->isHTML(true); 

return $mail;