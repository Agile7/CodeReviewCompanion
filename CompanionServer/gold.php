<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

shareGold();

function shareGold(){
	global $connection;
	$sql = "";
	if (isset($_GET['from']) && !empty($_GET['from']) &&
      isset($_GET['to']) && !empty($_GET['to']) &&
      isset($_GET['amount']) && !empty($_GET['amount'])){
		$from = $_GET['from'];
      $to = $_GET['to'];
      $amount = $_GET['amount'];
		$sqlUpdateTo = "UPDATE user SET user_gold = user_gold + ".$amount." WHERE user_id = ".$to;
      $resTo = $connection->query($sqlUpdateTo);
      $sqlUpdateFrom = "UPDATE user SET user_gold = user_gold - ".$amount." WHERE user_id = ".$from;
      $resFrom = $connection->query($sqlUpdateFrom);
      if ($resTo && $resFrom){
         print '{"successful": "true"}';
      } else {
         print '{"successful": "false"}';
      }
	}
}

?>
