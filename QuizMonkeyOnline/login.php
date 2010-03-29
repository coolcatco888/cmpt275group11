<?php
include_once('ScoreManager.php');
session_start();

$manager = new ScoreManager();

//Validate via ajax
$action = $_GET['action'];

$username = $_POST['username'];
$password = $_POST['password'];

//Authenticate user
if($action == 'authenticate') {
    if($manager->login_as_teacher($username, $password)) {
        $_SESSION['authenticated'] = true;
        echo "OK";
    } else {
        echo "FAILED";
    }

//Redirect to login page if not authenticated
} else if(!$_SESSION['authenticated']) {
    header('Location: '.'index.php');
}
?>