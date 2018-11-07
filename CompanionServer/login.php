<?php
header("Access-Control-Allow-Origin: *");
require('connection.php');
$connection = $conn;

echo login();

function login(){
	global $connection;
	$sql = "";
   // if (isset($_POST['user_id']) && !empty($_POST['user_id'])){
	if (isset($_GET['user_id']) && !empty($_GET['user_id'])){
		$user_id = $_GET['user_id'];
		$sql = "SELECT * FROM user WHERE user_id = ".$user_id;
      $result = $connection->query($sql);
   	$rows = array();
      // print $result;

   	if ($result->num_rows > 0) {
   	    // output data of each row
   	    while($row = $result->fetch_assoc()) {
             // GET STATS
             // get last login
             $last_login = $row['last_login'];

				 // getting project name
				 $project_id = $row['project_id'];
				 $query_get_project_name = "SELECT * from project WHERE project_id = ".$project_id;
				 $result_get_project_name = $connection->query($query_get_project_name);
				 $row_get_project_name = $result_get_project_name->fetch_assoc();
				 $row['project_name'] = $row_get_project_name['project_name'];

             // number of pushes
             $query_count_pushes = "SELECT * FROM code WHERE user_id = ".$user_id." AND push_date > '".$last_login."'";
             $result_count_pushes = $connection->query($query_count_pushes);
             $count_pushes = $result_count_pushes->num_rows;
             $row['count_pushes'] = $count_pushes;

             // number of reviews
             $query_reviews = "SELECT * FROM review WHERE reviewer_id = ".$user_id." AND submit_time > '".$last_login."'";
             $result_reviews = $connection->query($query_reviews);
             $count_reviews = $result_reviews->num_rows;
             $count_annotations = 0;
             while($review_row = $result_reviews->fetch_assoc()){
                $query_annotations = "SELECT * FROM review_annotation WHERE review_id = ".$review_row['review_id'];
                $result_query_annotations = $connection->query($query_annotations);
                $temp = $result_query_annotations->num_rows;
                $count_annotations += $temp;
             }
             $row['count_reviews'] = $count_reviews;
             $row['count_annotations'] = $count_annotations;

             // calculate XP difference
             $xp_difference = 0;
             $xp_difference += ($count_reviews * 5);
             $xp_difference += $count_annotations;

             // TODO: count the number of approved code
				 $query_code_pushed = "SELECT * FROM code WHERE user_id = ".$user_id;
				 $result_code_pushed = $connection->query($query_code_pushed);
				 if ($result_code_pushed->num_rows > 0){
					 while ($row_code_pushed = $result_code_pushed->fetch_assoc()) {
					 	$code_id = $row_code_pushed['code_id'];
						$version = $row_code_pushed['version'];
						$number_of_lines = $row_code_pushed['number_of_lines'];

						$query_check_new_code_review_result = "SELECT code_id, approved, submit_time FROM review
							WHERE code_id = ".$code_id.
							" AND submit_time > '".$last_login."' AND submit_time IN (
								SELECT max(submit_time) FROM review WHERE code_id = ".$code_id."
							)";
						$result_check_new_code_review_result = $connection->query($query_check_new_code_review_result);
						if ($result_check_new_code_review_result->num_rows > 0){
							$row_check_review = $result_check_new_code_review_result->fetch_assoc();
							$approved = $row_check_review['approved'];
							if ($approved == 1){
								if ($version == 1){
									$xp_difference += ceil($number_of_lines / 10);
								} else {
									$xp_difference += (ceil($number_of_lines / 20) - ($version - 2));
								}
							}
						}
					 }

				 }
				 $row['xp_diff'] = $xp_difference;
   	       $rows[] = $row;
   	    }
   	}

   	print json_encode($rows);

      //update last login
	}

}

?>
