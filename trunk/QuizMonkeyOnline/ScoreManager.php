<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ScoreManager
 *
 * @author cley
 */
class ScoreManager {
    var $mysql_host='localhost';
	var $db_name='quizmonkey';
	var $db_user='quizmonkey';
	var $db_pass='teamawesome';//Don't hack our database!

    function ScoreManager() {

    }

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

    function login($username, $password) {
        $login_success = false;

        $result = $this->execute_query("SELECT * FROM `user` WHERE userid='$username' AND password='$password';");

        while($row = mysql_fetch_array($result)) {
            $login_success = true;
            break;
        }

        return $login_success;

    }


}
?>
