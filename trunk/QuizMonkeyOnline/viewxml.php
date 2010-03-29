<?php
include_once('ScoreManager.php');

$manager = new ScoreManager();
echo $manager->generate_score_xml();

?>
