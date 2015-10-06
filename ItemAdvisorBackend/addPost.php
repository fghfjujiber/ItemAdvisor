<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $userid = $_POST["userid"];
    $content = $_POST["content"];
    $tags = explode(",", $_POST["tags"]);
    $no_view = 0;
    $time_stamp = time();
    $retJSON = array();
    $retJSON["result"] = "NO";
    $retJSON["description"] = "Failed to Insert Post (should not happen)";

    mysql_query("INSERT INTO `postDB` (user_id, content, no_view, time_stamp) values ('".$userid."','".$content."','".$no_view."','".$time_stamp."')");
    $post_id = mysql_insert_id();

    if($post_id > 0) {
        $retJSON["result"] = "YES";
        $retJSON["description"] = "Post Submitted";
        $retJSON["postid"] = $post_id;

        for($i=0; $i < count($tags); $i++) {
            $tag = explode(";", $tags[$i]);
            mysql_query("INSERT INTO `tagDB` (user_id, post_id, tag_type, tag_desc) values ('".$userid."','".$post_id."','".$tag[0]."','".$tag[1]."')");
        }
    }

    echo json_encode($retJSON);
?>