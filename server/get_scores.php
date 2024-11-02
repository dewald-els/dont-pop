<?php

const FILE_NAME = "./scores.json";
$env = parse_ini_file('.env');
/* Handle CORS */

// Specify domains from which requests are allowed
header('Access-Control-Allow-Origin: *');

// Specify which request methods are allowed
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');

// Additional headers which may be sent along with the CORS request
header('Access-Control-Allow-Headers: X-Requested-With,Authorization,Content-Type,x-api-key');

// Set the age to 1 day to improve speed/caching.
header('Access-Control-Max-Age: 86400');

// Exit early so the page isn't fully loaded for options requests
if (strtolower($_SERVER['REQUEST_METHOD']) == 'options') {
    exit();
}
try {

    if ($_SERVER["REQUEST_METHOD"] !== "GET") {
        echo "Illegal: Method not allowed";
        return;
    }

    if (!isset($env["API_KEY"])) {
        echo "Error: API Key not available in environment. Killing request";
        return;
    }

    if (!isset($_SERVER['HTTP_X_API_KEY'])) {
        echo "Error: No Key provided";
        return;
    }

    if ($env['API_KEY'] !== $_SERVER["HTTP_X_API_KEY"]) {
        echo "ERROR: Invalid Api key received. Killing request.";
        return;
    }


    $scores_text = file_get_contents(FILE_NAME);

    header('Content-Type: application/json');
    if (!$scores_text) {
        echo [];
    } else {

        echo $scores_text;
    }

} catch (Exception $error) {
    echo "Failed: " . $error->getMessage();
}
