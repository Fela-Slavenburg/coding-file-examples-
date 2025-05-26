<?php
session_start();
require "../Database/db.php";

// Als de gebruiker al ingelogd is, redirect naar homepage
if (isset($_SESSION['login_status']) && $_SESSION['login_status'] === true) {
    header("Location: ../Homepage/index.php");
    exit();
}

// Databaseverbinding maken
$db = new DB('BP');
$account = new Account($db);


// Verwerking van het loginformulier
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = htmlspecialchars($_POST['email']);
    $password = htmlspecialchars($_POST['password']);

    // Inlogpoging
    $user = $account->login($email, $password);

    if ($user) {
        if ($user['blocked']) {
            $error = "Je account is geblokkeerd.";
        } else {
            $_SESSION['login_status'] = true;
            $_SESSION['userID'] = $user['id'];
            $_SESSION['email'] = $user['email'];
            $_SESSION['user_type'] = $user['user_type'];

            // Admin doorsturen naar admin-dashboard
            if ($user['user_type'] === 'admin') {
                header("Location: ../admin/admin_dashboard.php");
            } else {
                header("Location: ../Homepage/index.php");
            }
            exit();
        }
    } else {
        // Foutmelding als login niet lukt
        $error = "Ongeldig e-mailadres of wachtwoord.";
        error_log("Login mislukt voor e-mailadres: " . $email);  // Foutmelding toevoegen
    }
}

?>

<!DOCTYPE html>
<html lang="nl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

    <?php include '../Nav_Bar/navbar.php'; ?>

    <style>
    .form-popup {
        display: none;
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    .form-popup.show {
        display: block;
        opacity: 1;
    }
    
    </style>

    <section>
        <div class="mx-auto w-full max-w-3xl px-5 py-16 md:px-10 md:py-20">
            <div class="mx-auto max-w-xl bg-gray-100 px-8 py-12 text-center">
                <h2 class="text-2xl font-bold">Inloggen</h2>

                <!-- Foutmelding tonen als er een probleem is -->
                <?php if (isset($error)): ?>
                    <p class="text-red-500"><?php echo $error; ?></p>
                <?php endif; ?>

                <form method="POST" action="login.php">
                    <div class="mb-4">
                        <input type="email" name="email" class="w-full p-2 border rounded" placeholder="E-mail" required>
                    </div>
                    <div class="mb-4">
                        <input type="password" name="password" class="w-full p-2 border rounded" placeholder="Wachtwoord" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-full">Login</button>
                </form>

                <p class="text-sm text-gray-500 mt-4">Geen account? <a href="../Register/register.html" class="font-bold">Registreer hier</a></p>

                <button type="button" class="btn btn-light" onclick="toggleForm()">Wachtwoord vergeten?</button>

                <div class="form-popup" id="myForm">
                    <form method="POST" action="mail-reset/sent-password-reset.php" class="form-container">
                        <input type="email" name="reset-email" id="reset-email" placeholder="e-mail" required><br>
                        <button type="submit" class="btn btn-primary mt-3">Verstuur code</button>
                    </form>
                    <button type="button" class="btn btn-secondary mt-3" onclick="toggleForm()">✕</button>
                </div>
            </div>
        </div>
    </section>

    <script>
        function toggleForm() {
            const form = document.getElementById("myForm");
            const isVisible = form.classList.contains("show");

            if (isVisible) {
                form.classList.remove("show");
                setTimeout(() => {
                    form.style.display = "none";
                }, 300); 
            } else {
                form.style.display = "block";
                setTimeout(() => {
                    form.classList.add("show");
                }, 10); 
            }
        }
    </script>
</body>
</html>

<!-- <?php echo "<!-- © 2025 Sufiyaan, Aladin, Fela en Yasin - Unauthorized use prohibited refer to license -->"; ?> -->