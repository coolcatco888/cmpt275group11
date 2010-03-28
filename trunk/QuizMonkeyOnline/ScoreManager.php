<?php

/**
 * Description of Handles storing and retrieval of QuizMonkey scores
 *
 * @author cley
 */
class ScoreManager {
    var $mysql_host='localhost';
	var $db_name='quizmonkey';
	var $db_user='quizmonkey';
	var $db_pass='teamawesome';//Don't hack our database!

    //Executes sql queries on the database
    protected function execute_query($sql) {
        $row = '';

        //Connect to the database
        $con = mysql_connect($this->mysql_host,
            $this->db_user,
            $this->db_pass);

        //If connection failed, throw error
        if (!$con) {
            die('Could not connect: ' . mysql_error());
        }

        //Select database and execute query
        mysql_select_db($this->db_name, $con);
        $result = mysql_query($sql);

        //Close Connection
        mysql_close();

        return $result;
    }

    //Authenticates login, returns true if login is a success, false if not
    function login($username, $password) {
        $login_success = false;

        $result = $this->execute_query("SELECT * FROM `user` WHERE userid='$username' AND password='$password';");

        while($row = mysql_fetch_array($result)) {
            $login_success = true;
            break;
        }

        return $login_success;

    }

    //Uniquely generates score id
    function generate_scoreid($username) {
        $scoreid = '';

        $result = $this->execute_query("SELECT * FROM `scores` WHERE userid='$username';");

        $scoreid = mysql_num_rows($result);

        return $scoreid;
    }

    //Inserts a score entry into the database
    function insert_score($username, $scoreid, $timeleft, $points, $maxpoints) {
        $this->execute_query("INSERT INTO `quizmonkey`.`scores` (`userid` ,`scoreid` ,`timeleft` ,`date` ,`points` ,`maxpoints`) "
            ."VALUES ('$username', '$scoreid', '$timeleft', CURDATE( ) , '$points', '$maxpoints');");
    }

    function retrieve_all_scores() {
        
    }


}
?>
