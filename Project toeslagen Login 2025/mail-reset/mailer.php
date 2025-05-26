<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\SMTP;

require __DIR__ . "/vendor/autoload.php";
function createMailer($resetemail, $resetLink) {

$mail = new PHPMailer(true);

try {
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->SMTPAuth = true;
    $mail->Username = "cottoncloud606@gmail.com"; // email addres zender
    $mail->Password = "lkji rngt mznh nnzf";
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port = 587;

    $mail->setFrom('cottoncloud606@gmail.com', 'Toeslag'); // Naam bedrijf

    $mail->addAddress($resetemail);

    $mail->isHTML(true);
    $mail->Subject = 'Wachtwoord Reset';
    $mail->Body    = "
        <p>Beste gebruiker,</p>
        <p>U heeft een verzoek ingediend om uw wachtwoord te resetten. Klik alstublieft op de onderstaande link om uw wachtwoord te resetten.</p>
        <p><a href=\"$resetLink\">Reset hier</a></p>
        <p>Als u dit verzoek niet heeft gedaan, kunt u deze e-mail negeren.</p>
        <p>Met vriendelijke groet,<br>Het Toeslag Team</p>"; // Wachtwoord reset link

    $mail->send();
} catch (Exception $e) {
    echo "De e-mail kon niet worden verzonden. Mailer Error: {$mail->ErrorInfo}";
    return null;
}

$mail->isHTML(true); 

return true;
}