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
            });
        </script>
        <title>Quiz Monkey - Teacher Login</title>
    </head>
    <body>
        <div id='content'>
            <img src="images/banner.png" alt="Quiz Monkey Student Progress Monitoring System"/>
            <h1>Student Progress Monitoring System</h1>
            <form action="javascript:void(0);" name="form" id="login">
                <div id='loginbox' class='display'>
                    <h2>Teacher Login</h2>
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
                    <div id='authenticated'>
                        <h2>User Authenticated. Please Wait...</h2>
                        <img src="images/loading.gif" alt="loading"/>
                    </div>
                    <div id='error'>
                        Error: Username/Password is incorrect!
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
