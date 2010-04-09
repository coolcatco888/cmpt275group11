<?php
include_once('ScoreManager.php');
session_start();

$manager = new ScoreManager();

//Validate via ajax
$action = $_GET['action'];

$username = $_POST['username'];
$password = $_POST['password'];

$_SESSION['username'] = $username;

//Authenticate user
if($action == 'authenticate') {
    $_SESSION['authenticated'] = true;
    if($manager->login_as_teacher($username, $password)) {
        $_SESSION['usertype'] = "teacher";
        echo "OK";
    } else if($manager->login($username, $password)) {
        $_SESSION['usertype'] = "student";
        echo "OK";
    } else {
        $_SESSION['authenticated'] = false;
        echo "FAILED";
    }

//Redirect to login page if not authenticated
} else if(!$_SESSION['authenticated']) {
    header('Location: '.'index.php');
}
?>