<?php session_start(); ?>
<?php include_once "dbconfig.php";?>
<?php 
  $from_id = $_SESSION['userid'];
  $to_id = $_POST["transaction_to"];
  $amount = $_POST["transaction_amount"];
  $date = time();
  $description = $_POST['transaction_description'];
  if(!empty($from_id) && !empty($to_id) && !empty($amount) && !empty($description))
  {
    mysql_query("INSERT INTO `transactions` (from_id, to_id, amount, transaction_date, description) VALUES ('$from_id', '$to_id', '$amount', '$date', '$description')");
  }
  header('Location:index.php');
?>