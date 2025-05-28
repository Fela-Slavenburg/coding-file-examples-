<?php
    session_start();

    require_once "../database/pokedexDB.php";
    require_once "../database/pokemon_functions.php";

    $pokemonGegevens = null;

    if (isset($_GET['id'])) {
        $db = new pokedex('pokedex');
        $pokemon = new Pokemon($db);

        $pokemonGegevens = $pokemon->selectPokemonGegevensById($_GET['id']);

        if ($pokemonGegevens) {
            $pokemonGegevens['picture'] = htmlspecialchars($pokemonGegevens['picture']);
            $pokemonGegevens['name'] = htmlspecialchars($pokemonGegevens['name']);
            $pokemonGegevens['type_1'] = htmlspecialchars($pokemonGegevens['type_1']);
            $pokemonGegevens['type_2'] = htmlspecialchars($pokemonGegevens['type_2']);
            $pokemonGegevens['abilities'] = htmlspecialchars($pokemonGegevens['abilities']);
            $pokemonGegevens['evolution'] = htmlspecialchars($pokemonGegevens['evolution']);
            $pokemonGegevens['description'] = htmlspecialchars($pokemonGegevens['description']);
        } elseif (!$pokemonGegevens) {
            echo "No pokemon information found.";
            $pokemonGegevens = null;
            exit;
        }
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

<div class="container mt-5">
    <?php if ($pokemonGegevens): ?>
        <h1 class="text-center"><?php echo $pokemonGegevens['name']; ?></h1>
        <div class="text-center">
            <img src="<?php echo $pokemonGegevens['picture']; ?>" 
                 alt="<?php echo $pokemonGegevens['name']; ?>" 
                 class="img-fluid rounded">
        </div>
        <div class="mt-4">
            <h3>Type:</h3>
            <p>
                <?php echo $pokemonGegevens['type_1']; ?>
                <?php if (!empty($pokemonGegevens['type_2'])): ?>
                    / <?php echo $pokemonGegevens['type_2']; ?>
                <?php endif; ?>
            </p>
            <h3>Abilities:</h3>
            <p><?php echo $pokemonGegevens['abilities']; ?></p>
            <h3>Evolution:</h3>
            <p><?php echo $pokemonGegevens['evolution']; ?></p>
            <h3>Description:</h3>
            <p><?php echo $pokemonGegevens['description']; ?></p>
        </div>
    <?php else: ?>
        <p class="text-center text-danger">No Pokémon information found.</p>
    <?php endif; ?>
    <div class="text-center mt-4">
        <a href="pokemon.php" class="btn btn-primary">Back to Pokedex</a>
    </div>
</div>


</body>
</html>