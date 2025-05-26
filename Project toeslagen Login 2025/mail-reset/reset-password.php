<?php
$mysqli = require __DIR__ . "/../../Database/db.php"; 
$dbConnection = new DB('BP');

if (!isset($_GET["token"]) || empty($_GET["token"])) {
    die("Geen token opgegeven in de URL.");
}

$token = $_GET["token"];
$token_hash = hash("sha256", $token);

$sql = "SELECT * FROM accounts WHERE reset_token_hash = ?"; 
$stmt = $dbConnection->execute($sql, [$token_hash]); 

$account = $stmt->fetch(PDO::FETCH_ASSOC); 

if ($account === false) {
    die("token not found");
}

if (strtotime($account["reset_token_expires_at"]) <= time()) {
    die("Token is expired.");
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Wachtwoord</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    
    <h1>Reset Wachtwoord</h1>

        

</body>
</html>

<button type="submit">Reset wachtwoord</button>

<section>
  <div class="min-h-screen flex items-center justify-center">
    <div class="bg-white px-14 py-8 rounded-lg border lg:w-[768px] border-gray-400 max-w-lg lg:max-w-[768px]">
      <form method="POST" action="process-reset-password.php" class="py-14">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <input type="hidden" name="token" value="<?= htmlspecialchars($token) ?>">

          <div>
            <label for="password" class="block font-semibold text-black">
                Nieuw wachtwoord
            </label>
            <input type="password" name="password" id="password" required class="mt-2 block w-full h-12 rounded-md border border-gray-400 shadow-sm  sm:text-sm md:text-base pl-3" />
          </div>
          <div>
            <label for="password_confirmation" class="block font-semibold text-black">
                Bevestig nieuw wachtwoord
            </label>
            <input type="password" name="password_confirmation" id="password_confirmation" required class="mt-2 block w-full h-12 rounded-md border border-gray-400 shadow-sm  sm:text-sm md:text-base pl-3" />
          </div>
        </div>
            <button type="submit" class="px-5 py-2 border border-transparent rounded-md shadow-sm font-semibold text-white bg-black hover:bg-gray-800">
                Reset wachtwoord
            </button>
      </form>
      <div class="flex justify-end">
      </div>
    </div>
  </div>
</section>
