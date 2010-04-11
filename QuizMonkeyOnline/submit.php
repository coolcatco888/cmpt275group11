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
$achievements = $_GET['achievements'];

$allnumerical = false;
if(is_numeric($timeleft) && is_numeric($points) && is_numeric($maxpoints)) {
    $allnumerical = true;
}
$loginsuccess = $manager->login($username, $password);

//If login is a success, submit score
if($loginsuccess && $allnumerical) {
    $scoreid = $manager->generate_scoreid($username);
    $manager->insert_score_with_achievenents($username, $scoreid, $timeleft, $points, $maxpoints, $achievements);
} else {
   //return error
   $error = "FAILED";
}

echo $error;

?>