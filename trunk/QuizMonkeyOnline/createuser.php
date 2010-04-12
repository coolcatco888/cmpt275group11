<?php
include_once('ScoreManager.php');

session_start();
$manager = new ScoreManager();

$username = $_POST['username'];
$password = $_POST['password'];
$confirmpassword = $_POST['confirmpassword'];
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];

$status = '';
//Must check if all filled out
if(empty($username) || empty($password)|| empty($confirmpassword)|| empty($firstname)|| empty($lastname)) {
	$status = 'You need to fill out all fields!';
//Passwords do not match	
} else if($password != $confirmpassword) {
	$status = "Passwords do not match";
//Try to create user
} else {
	$status = $manager->create_new_user($username, $password, $firstname, $lastname);
}

echo $status;

?>