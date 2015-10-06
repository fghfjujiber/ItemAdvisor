<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $username = $_POST["email"];
    $password = md5($_POST["password"]);
    $firstname = $_POST["firstname"];
    $lastname = $_POST["lastname"];
    $description = $_POST["desc"];
    $query = mysql_query("SELECT * FROM `userDB` WHERE email = '" . $username . "' OR firstname = '".$firstname."'");

    $retJSON = array();
    $retJSON["result"] = "NO";
    $retJSON["description"] = "Username or password incorrect.";
    if($result = mysql_fetch_assoc($query)) {
        $retJSON["description"] = "Username or password incorrect.";
    } else {
        mysql_query("INSERT INTO `userDB` (email, firstname, lastname, password, description) values ('".$username."','".$firstname."','".$lastname."','".$password."','".$description."')");
        $retJSON["result"] = "YES";
        $retJSON["description"] = "User Registered";
        $retJSON["useremail"] = $username;
    }

    echo json_encode($retJSON);
?>