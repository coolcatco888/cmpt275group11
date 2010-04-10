<?php
include_once('ScoreManager.php');
session_start();

if(!$_SESSION['authenticated']) {
    header('Location: '.'index.php');
}
$username = $_SESSION['username'];
$usertype = $_SESSION['usertype'];
$manager = new ScoreManager();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <?php
        include_once('includes/head.inc');
        ?>
        <script type="text/javascript">
            $(document).ready(function(){
            	$("#legend").hide();
            	$('#show').click(function() {
		  if($('#legend').is(":visible")) {
		  	$("#legend").hide();
		  } else {
		  	$("#legend").show();
		  }
		});
            });
        </script>
        <title>Quiz Monkey - Student Scores</title>
    </head>
    <body>
        <div id='content'>
            <img src="images/banner.png" alt="Quiz Monkey Student Progress Monitoring System"/>
            <h1>Student Scores</h1>
            <div id='scorebox' class='display'>
            <p>
            <a href="javascript:void(0);" id="show">Show/Hide Sticker Legend</a> <a href="index.php">Logout</a>
            </p>
            <div id="legend">
            <h2>Sticker Legend</h2>
            
	            <ul>
	            	<li><img src='images/icons/0.png' alt='Achievement' /> Banana Man - You have achieved a 90% score or greater on the quiz.</li>
	            	<li><img src='images/icons/1.png' alt='Achievement' /> Quiz Passed - You have achieved a 50% score or greater on the quiz.</li>
	            	<li><img src='images/icons/2.png' alt='Achievement' /> Teacher's Pet - You have correctly answered 5 questions in a row.</li>
	            	<li><img src='images/icons/3.png' alt='Achievement' /> Grammar Master - You are the master of all things gramatical.</li>
	            	<li><img src='images/icons/4.png' alt='Achievement' /> Vocabulary Master - You are the master of vocabulary.</li>
	            	<li><img src='images/icons/5.png' alt='Achievement' /> Speed Demon - You have completed the quiz in half the time.</li>
	            </ul>
            </div>
            <?php
            if($usertype == 'teacher') {
                echo $manager->generate_score_table();
            } else {
                echo $manager->generate_user_score_table($username);
            }
            ?>
            <p>
            <a href="index.php">Logout</a>
            </p>
            </div>
        </div>
    </body>
</html>