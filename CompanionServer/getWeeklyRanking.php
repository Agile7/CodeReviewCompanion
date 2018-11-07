<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo getWeeklyRank();

function getWeeklyRank(){
	global $connection;
	$sql = "Select u.user_id, u.first_name,u.last_name,
	p.project_name, (u.user_xp-uh.user_xp) as diff
	FROM User u, user_history uh, project p
	WHERE u.project_id = p.project_id
	AND u.user_id = uh.user_id
	ORDER BY diff DESC";
	
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
