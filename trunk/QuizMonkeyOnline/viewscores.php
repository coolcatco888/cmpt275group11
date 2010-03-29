<?php
include_once('ScoreManager.php');
session_start();

if(!$_SESSION['authenticated']) {
    header('Location: '.'index.php');
}

$manager = new ScoreManager();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <?php
        include_once('includes/head.inc');
        ?>
        <title>Quiz Monkey - Student Scores</title>
    </head>
    <body>
        <div id='content'>
            <img src="images/banner.png" alt="Quiz Monkey Student Progress Monitoring System"/>
            <h1>Student Scores</h1>
            <div id='scorebox' class='display'>
            <?php
            echo $manager->generate_score_table();
            ?>
            <p>
            <a href="index.php">Logout</a>
            </p>
            </div>
        </div>
    </body>
</html>