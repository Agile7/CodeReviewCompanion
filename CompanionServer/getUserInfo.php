<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo getUserInfo();

function getUserInfo(){
	global $connection;
	$sql = "";
	if (isset($_GET['user_id']) && !empty($_GET['user_id'])){
		$user_id = $_GET['user_id'];
		$sql = "SELECT * FROM user WHERE user_id = ".$user_id;
	} else {
		$sql = "SELECT * FROM user";
	}

	$result = $connection->query($sql);
	$rows = array();

	if ($result->num_rows > 0) {
	    // output data of each row
	    while($row = $result->fetch_assoc()) {
	        $rows[] = $row;
	    }
	}

	print json_encode($rows);

}

?>
