<?php
session_start();

$_SESSION['authenticated'] = false;

?>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <?php
        include_once('includes/head.inc');
        ?>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#authenticated").hide();
                $("#error").hide();
                $("#status").hide();
                
            	$("#createusertable").hide();
            	$('#createuserbutton').click(function() {
		  if($('#createusertable').is(":visible")) {
		  	$("#createusertable").hide();
		  	$("#status").hide();
		  	$("#status").text('');
		  } else {
		  	$("#createusertable").show();
		  	$("#status").show();
		  }
		});
                
                //Ajax Login
                $("#login").submit(function(){

                    var str = $(this).serialize();

                    $.ajax({
                        type: "POST",
                        url: "login.php?action=authenticate",
                        data: str,
                        success: function(msg) {
                            $("#error").ajaxComplete(function(event, request, settings){
                                if(msg == 'OK'){
                                    $("#authenticated").show();
                                    $("#logintable").hide();
                                    $("#error").hide();
                                    $("#createusertable").hide();
		  		    $("#status").hide();
                                    window.location = "viewscores.php";
                                } else {
                                    $("#error").show();
                                    result = msg;
                                }
                            });
                        }
                    });
                    return false;
                });
                
                //Ajax create user
                $("#createuser").submit(function(){

                    var str = $(this).serialize();

                    $.ajax({
                        type: "POST",
                        url: "createuser.php",
                        data: str,
                        success: function(msg) {
                            $("#status").ajaxComplete(function(event, request, settings){
                                $("#status").show();
                                $("#status").text(msg);
                            });
                        }
                    });
                    return false;
                });
            });
        </script>
        <title>Quiz Monkey - Teacher Login</title>
    </head>
    <body>
        <div id='content'>
            <img src="images/banner.png" alt="Quiz Monkey Student Progress Monitoring System"/>
            <h1>Student Progress Monitoring System</h1>
            
                <div id='loginbox' class='display'>
                    <h2>User Login</h2>
                    <form action="javascript:void(0);" name="form" id="login">
                    <table id="logintable">
                        <tbody>
                            <tr>
                                <td>Username:</td>
                                <td><input type="text" name="username" value="" /></td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="password" name="password" value="" /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="reset" value="Reset" name="reset" class="formbuttons"/>
                                    <input type="submit" value="Submit" name="submit" class="formbuttons"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </form>
                    <div id='authenticated'>
                        <h2>User Authenticated. Please Wait...</h2>
                        <img src="images/loading.gif" alt="loading"/>
                    </div>
                    <div id='error'>
                        Error: Username/Password is incorrect!
                    </div>
                    <p>
                    	<a href="javascript:void(0);" id="createuserbutton">Create New User</a>
                    </p>
                    
                    <div id='status'></div>
                    <form action="javascript:void(0);" name="form2" id="createuser">
                    <table id="createusertable">
                        <tbody>
                            <tr>
                                <td>Username:</td>
                                <td><input type="text" name="username" value="" /></td>
                            </tr>
                            <tr>
                                <td>First Name:</td>
                                <td><input type="text" name="firstname" value="" /></td>
                            </tr>
                            <tr>
                                <td>Last Name:</td>
                                <td><input type="text" name="lastname" value="" /></td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="password" name="password" value="" /></td>
                            </tr>
                            <tr>
                                <td>Confirm Password:</td>
                                <td><input type="password" name="confirmpassword" value="" /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="reset" value="Reset" name="reset" class="formbuttons"/>
                                    <input type="submit" value="Submit" name="submit" class="formbuttons"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </form>
                </div>
            
        </div>
    </body>
</html>