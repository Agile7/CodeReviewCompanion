<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo getUserList();

function getUserList(){
	global $connection;
	$sql = "";
	if (isset($_GET['project_id']) && !empty($_GET['project_id'])){
		$project_id = $_GET['project_id'];
		$sql = "SELECT * FROM user WHERE project_id = ".$project_id;
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
