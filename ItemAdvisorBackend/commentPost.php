<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $userid = $_POST["userid"];
    $postid = $_POST["postid"];
    $replyid = $_POST["replyid"] ? $_POST["replyid"] : 0;
    $content = $_POST["content"];
    $time_stamp = time();
    $retJSON = array();

    mysql_query("INSERT INTO `commentDB` (user_id, reply_id, post_id, content, time_stamp) values ('".$userid."','".$replyid."','".$postid."','".$content."','".$time_stamp."')");

    $retJSON["result"] = "YES";
    $retJSON["description"] = "Comment Submitted";

    echo json_encode($retJSON);
?>