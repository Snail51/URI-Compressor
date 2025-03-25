<?php

// enable error reporting
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$maxLength = 8192;

// unpack encoding over GET (encoded -> raw)
if ($_SERVER['REQUEST_METHOD'] === 'GET')
{
    // abort on malicious input
    $check = strlen(print_r($_GET, true));
    if( $check > $maxLength )
    {
        echo "Data too long ({$check}/{$maxLength}). Aborting.";
        exit;
    }

    // Check all keys are present
    $requiredKeys = ['enc', 'cmpr', 'data'];
    $allPresent = true;
    foreach ($requiredKeys as $key) {
        if (!array_key_exists($key, $_GET)) {
            $allPresent = false;
            break;
        }
    }
    if(!$allPresent)
    {
        echo "Not enough URI parameters provided.";
    }

    $encoding = htmlspecialchars($_GET["enc"]);
    $compression = htmlspecialchars($_GET["cmpr"]);
    $data = htmlspecialchars($_GET["data"]);

    $cmd = "node /mnt/hdd/web/URICompressor/api.js \"DECODE\" \"{$encoding}\" \"{$compression}\" \"{$data}\"";
    $output = shell_exec($cmd);

    echo $output;
    exit;
}

// package over POST (raw -> encoded)
if ($_SERVER['REQUEST_METHOD'] === 'POST')
{
    // abort on malicious input
    $check = strlen(print_r($_POST, true));
    if( $check > $maxLength )
    {
        echo "Data too long ({$check}/{$maxLength}). Aborting.";
        exit;
    }

    // Check all keys are present
    $requiredKeys = ['enc', 'cmpr', 'data'];
    $allPresent = true;
    foreach ($requiredKeys as $key) {
        if (!array_key_exists($key, $_GET)) {
            $allPresent = false;
            break;
        }
    }
    if(!$allPresent)
    {
        echo "Not enough URI parameters provided.";
    }

    $encoding = htmlspecialchars($_GET["enc"]);
    $compression = htmlspecialchars($_GET["cmpr"]);
    $data = htmlspecialchars($_GET["data"]);

    $cmd = "node /mnt/hdd/web/URICompressor/api.js \"ENCODE\" \"{$encoding}\" \"{$compression}\" \"{$data}\"";
    $output = shell_exec($cmd);

    echo $output;
    exit;
}

?>
