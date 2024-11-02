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

    $_POST = json_decode(file_get_contents("php://input"), true);
    if (!isset($_POST["scores"])) {
        echo "Error: No Scores received";
        return;
    }

    $scores = $_POST["scores"];

    $valid_scores = array_filter(
        $scores,
        function ($score) {
            return isset($score["name"]) && isset($score["score"]);
        }
    );

    file_put_contents(FILE_NAME, json_encode($valid_scores));

} catch (Exception $error) {
    echo "Failed: " . $error->getMessage();
}


function getRequestHeaders()
{
    $headers = array();
    foreach ($_SERVER as $key => $value) {
        if (substr($key, 0, 5) <> 'HTTP_') {
            continue;
        }
        $header = str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($key, 5)))));
        $headers[$header] = $value;
    }
    return $headers;
}
