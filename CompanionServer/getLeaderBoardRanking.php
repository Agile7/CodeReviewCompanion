<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo getUserRank();

function getUserRank(){
	global $connection;
	$sql = "Select u.user_id, u.first_name,u.last_name,
	u.user_xp, u.photo, p.project_name
	FROM User u, project p
	WHERE u.project_id = p.project_id
	ORDER BY u.user_xp DESC";
	
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
