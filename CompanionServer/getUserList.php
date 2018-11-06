<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo getProjectList();


function getProjectList(){

	global $connection;
	//building the query
	$sql = "SELECT p.project_id, p.project_name
			FROM project p";

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