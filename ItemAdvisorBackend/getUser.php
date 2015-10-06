<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php 
    $user_query = mysql_query("SELECT * FROM `userDB` WHERE id = '".$_POST['userid']."'");

    $retJSON = array();
    $retJSON["result"] = "NO";
    $retJSON["description"] = "Failed to Get User (should not happen)";

    while($result = mysql_fetch_assoc($user_query)) {
        $userdata = array();

        $userdata["userid"] = $result['id'];
        $userdata["email"] = $result['email'];
        $userdata["firstname"] = $result['firstname'];
        $userdata["lastname"] = $result['lastname'];
        $userdata["description"] = $result['description'];

        $userid = $result['id'];

        $post_query         = mysql_query("SELECT count(*) AS nopost FROM `postDB` WHERE user_id = '".$userid."'");
        $following_query    = mysql_query("SELECT count(*) AS nofollowing FROM `followDB` WHERE follower_id = '".$userid."'");
        $follower_query     = mysql_query("SELECT count(*) AS nofollower FROM `followDB` WHERE following_id = '".$userid."'");
        $item_query         = mysql_query("SELECT count(*) AS noitem FROM `tagDB` WHERE user_id = '".$userid."'");

        while($post_result = mysql_fetch_assoc($post_query)) {
            $userdata["no_post"] = $post_result['nopost'];
        }

        while($following_result = mysql_fetch_assoc($following_query)) {
            $userdata["no_following"] = $following_result['nofollowing'];
        }

        while($follower_result = mysql_fetch_assoc($follower_query)) {
            $userdata["no_follower"] = $follower_result['nofollower'];
        }

        while($item_result = mysql_fetch_assoc($item_query)) {
            $userdata["no_items"] = $item_result['noitem'];
        }

        $retJSON["user_data_request"] = $userdata;
        $retJSON["result"] = "YES";
        $retJSON["description"] = "Success";
    }
    

    echo json_encode($retJSON);
?>