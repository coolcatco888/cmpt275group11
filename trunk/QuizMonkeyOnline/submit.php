<?php

include_once('ScoreManager.php');
session_start();

$manager = new ScoreManager();
$error = '';
//Login Information
$username = $_GET['username'];
$password = $_GET['password'];

//Score Variables
$timeleft = $_GET['timeleft'];
$points = $_GET['points'];
$maxpoints = $_GET['maxpoints'];

$allnumerical = false;
if(is_int($timeleft) && is_int($points) && is_int($maxpoints)) {
    $allnumerical = true;
}

//If login is a success, submit score
if($manager->login($username, $password) && $allnumerical) {
    $scoreid = $manager->generate_scoreid($username);
    $manager->insert_score($username, $scoreid, $timeleft, $points, $maxpoints);
} else {
   $error = "Unable to submit score, username/password is incorrect";
}

//TODO - Process error here


?>