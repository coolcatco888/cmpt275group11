<?php

include_once('ScoreManager.php');
session_start();

$manager = new ScoreManager();
$username = $_GET['username'];
$password = $_GET['password'];

$manager->login($username, $password);


?>