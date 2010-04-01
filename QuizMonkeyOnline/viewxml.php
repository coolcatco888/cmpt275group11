<?php
include_once('ScoreManager.php');

$manager = new ScoreManager();

//Get user credentials
$username = $_GET['username'];
$password = $_GET['password'];

//Failed message will display if no valid credentials have been provided
$xml = 'FAILED';

//Login as teacher first, if it succeeds display everything
if($manager->login_as_teacher($username, $password)) {
	$xml = $manager->generate_score_xml();
//Login as any user, only display the user's scores
} else if($manager->login($username, $password)) {
	$xml = $manager->generate_user_score_xml($username);
}

//TODO - Delete the line below once iPhone part is finished!
$xml = $manager->generate_score_xml();

echo $xml;

?>