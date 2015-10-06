<?php

define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'Developer');
define('DB_PASSWORD', 'Bazinga');
define('DB_DATABASE', 'itemadvisor');
$connection = mysql_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD) or die(mysql_error());
$database = mysql_select_db(DB_DATABASE) or die(mysql_error());

?>