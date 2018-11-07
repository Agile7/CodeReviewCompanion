<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
require('utils.php');
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
			  $row['level'] = getLevelFromXP($row['user_xp']);
			  $row['remainder_xp'] = $row['user_xp'] - getTotalRequiredXpForLevel($row['level']);
	        $rows[] = $row;
	    }
	}

	print json_encode($rows);

}

?>
