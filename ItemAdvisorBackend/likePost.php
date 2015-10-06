<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $userid = $_POST["userid"];
    $postid = $_POST["postid"];
    $flag = $_POST["flag"];
    $retJSON = array();

    mysql_query("INSERT INTO `likeDB` (user_id, post_id, flag) values ('".$userid."','".$postid."','".$flag."')");

    $retJSON["result"] = "YES";
    $retJSON["description"] = "Like Submitted";

    echo json_encode($retJSON);
?>