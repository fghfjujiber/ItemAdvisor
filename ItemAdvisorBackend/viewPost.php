<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $postid = $_POST["postid"];

    $query = mysql_query("SELECT id,no_view FROM `postDB` WHERE user_id = ". $postid ."'");

    $retJSON = array();
    $retJSON["result"] = "NO";
    $retJSON["description"] = "post not found";

    while($result = mysql_fetch_assoc($post_query)) {
        // construct results here
        $noview = $result["no_view"];
        $noview = $noview + 1;
        mysql_query("UPDATE `postDB` SET no_view = ".$noview." WHERE id = ". $result["id"] ."'");

        $retJSON["result"] = "YES";
        $retJSON["description"] = "View No. Increased";
    }

    echo $retJSON;
?>