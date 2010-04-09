<?php

/**
 * Description of Handles storing and retrieval of QuizMonkey scores
 *
 * @author cley
 */
class ScoreManager {
    var $mysql_host='localhost';
	var $db_name='quizmonk_data';
	var $db_user='quizmonk_quizmon';
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
        return $this->login_with_type($username, $password, 'any');
    }

    function login_as_teacher($username, $password) {
        return $this->login_with_type($username, $password, 'teacher');
    }

    protected function login_with_type($username, $password, $usertype) {
        $login_success = false;

        $withtype = '';
        switch($usertype) {
            case 'student':
                $withtype = " AND type=0";
                break;
            case 'teacher':
                $withtype = " AND type=1";
                break;
        }

        $sql = "SELECT * FROM `user` WHERE userid='$username' AND password='$password'$withtype;";

        $result = $this->execute_query($sql);

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
        $this->execute_query("INSERT INTO `quizmonk_data`.`scores` (`userid` ,`scoreid` ,`timeleft` ,`date` ,`points` ,`maxpoints`) "
            ."VALUES ('$username', '$scoreid', '$timeleft', NOW(), '$points', '$maxpoints');");
    }

    function retrieve_all_scores() {
    	$result = $this->retrieve_user_scores('');
        return $result;
    }
    
    function retrieve_user_scores($username) {
    	$filter = '';
    	
    	//Add a username filter if a username is specified,
    	//otherwise select everything
    	if($username != '' || is_null($username)) {
    		$filter = " WHERE user.userid='$username' ";
    	}
    	
        $result = $this->execute_query("SELECT * FROM `user` "
            ."INNER JOIN `scores` "
            ."ON user.userid=scores.userid "
            .$filter
            ."ORDER BY user.userid ASC, scores.scoreid DESC;");

        return $result;
    }
    
    function generate_score_table() {
        return $this->generate_user_score_table('');
    }
    
    function generate_user_score_table($username) {
        //Default message to indicate that there are no scores to display
        $html = '<p>No Scores to Display</p>';
        
        $scores;
        if($username != '' && $username != null) {
            $scores = $this->retrieve_user_scores($username);
        } else {
            $scores = $this->retrieve_all_scores();
        }

        $currentuser = '';
        
        $noscores = false;
        
        //If there are scores to display then show the table
        if(mysql_num_rows($scores) != 0) {
        	$html = '<table>';
	        while($row = mysql_fetch_array($scores)) {
	            if($row['userid'] != $currentuser) {
	                $html .= "<tr><td colspan='5'>Student ID: ".$row['userid']." | Name: ".$row['firstname']." ".$row['lastname']."</td></tr>";
	                $currentuser = $row['userid'];
	                $html .= "<tr>"
	                ."<th>Score ID</th>"
	                ."<th>Time Left</th>"
	                ."<th>Date</th>"
	                ."<th>Points</th>"
	                ."<th>Max Points</th>"
	                ."</tr>";
	            }
	
	            $html .= "<tr>"
	                ."<td>".$row['scoreid']."</td>"
	                ."<td>".$row['timeleft']."</td>"
	                ."<td>".$row['date']."</td>"
	                ."<td>".$row['points']."</td>"
	                ."<td>".$row['maxpoints']."</td>"
	                ."</tr>";
	        }
	        $html .= '</table>';
        }
        return $html;
    }

    //Generates an xml representation of the high scores
    function generate_score_xml() {
    	$html = $this->generate_user_score_xml('');
        return $html;
    }
    
    function generate_user_score_xml($username) {
        $html = '<scores>';
        
        $scores = $this->retrieve_user_scores($username);

        while($row = mysql_fetch_array($scores))
        {
            $html .= "<score>"
		."<userid>".$row['userid']."</userid>"
		."<firstname>".$row['firstname']."</firstname>"
		."<lastname>".$row['lastname']."</lastname>"
		."<email>".$row['email']."</email>"
                ."<scoreid>".$row['scoreid']."</scoreid>"
                ."<timeleft>".$row['timeleft']."</timeleft>"
                ."<date>".$row['date']."</date>"
                ."<points>".$row['points']."</points>"
                ."<maxpoints>".$row['maxpoints']."</maxpoints>"
                ."</score>";
        }

        $html .= '</scores>';

        return $html;
    }


}
?>