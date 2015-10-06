<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
    $query_string = "SELECT `postDB`.*,`userDB`.email,`userDB`.firstname FROM `postDB` INNER JOIN `userDB` ON `postDB`.user_id = `userDB`.id";
    if($_POST["userid"]) {
        $userid = $_POST["userid"];
        $query_string .= " WHERE user_id = '".$userid."' ORDER BY time_stamp DESC LIMIT 10";
    } else {
        $query_string .= " ORDER BY time_stamp DESC LIMIT 10";
    }
    $post_query = mysql_query($query_string);

    $retJSON = array();
    $retJSON["result"] = "NO";
    $retJSON["description"] = "Failed to Get Post (should not happen)";
    $postlist = array();
    while($result = mysql_fetch_assoc($post_query)) {
        // construct results here
        $post_id = $result["id"];
        $img_query    = mysql_query("SELECT * FROM `imgDB` WHERE post_id = '".$post_id."'");
        $tag_query    = mysql_query("SELECT * FROM `tagDB` WHERE post_id = '".$post_id."'");

        $img_array = array();
        $tag_array = array();

        while($img_result = mysql_fetch_assoc($img_query)) {
            array_push($img_array, $img_result);
        }
        $result["imgs"] = $img_array;
        while($tag_result = mysql_fetch_assoc($tag_query)) {
            array_push($tag_array, $tag_result);
        }
        $result["tags"] = $tag_array;
        array_push($postlist, $result);
    }
    $retJSON["posts"] = $postlist;
    $retJSON["result"] = "YES";
    $retJSON["description"] = "Success";

    echo json_encode($retJSON);
?>