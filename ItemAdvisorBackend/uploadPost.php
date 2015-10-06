<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php
if ($_FILES["file"]["size"] < 2000000) {
    if ($_FILES["file"]["error"] > 0) {
        echo '{"Return Code":"' . $_FILES["file"]["error"] . '", "result":"NO"}';
    } else {
        $filename = basename($_FILES["file"]["name"],'.jpg');
        $postid = $filename;
        $filename .= "." . uniqid("post_") . '.jpg';
        $file_path = dirname(__FILE__) . "\\img\\post\\" . $filename;
        move_uploaded_file($_FILES["file"]["tmp_name"], $file_path);
        mysql_query("INSERT INTO `imgDB` (post_id, img) values ('".$postid."','".$filename."')");

        echo '{';
        echo '"Upload":"' . $filename . '",';
        echo '"Size":"' . $_FILES["file"]["size"] . '",';
        echo '"result":"YES","description":"DONE"';
        echo '}';
    }
} else {
    echo '{"result":"NO","description":"File Size > 200kb"}';
}
?>