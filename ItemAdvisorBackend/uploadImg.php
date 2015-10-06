<?php
if ($_FILES["file"]["size"] < 2000000) {
    if ($_FILES["file"]["error"] > 0) {
        echo '{"Return Code":"' . $_FILES["file"]["error"] . '", "result":"NO"}';
    } else {
        echo '{';
        echo '"Upload":"' . $_FILES["file"]["name"] . '",';
        echo '"Size":"' . $_FILES["file"]["size"] . '",';
        $file_path = dirname(__FILE__) . "\\img\\profile\\" . $_FILES["file"]["name"];
        move_uploaded_file($_FILES["file"]["tmp_name"], $file_path);
        echo '"result":"YES","description":"DONE"';
        echo '}';
    }
} else {
    echo '{"result":"NO","description":"File Size > 200kb"}';
}
?>