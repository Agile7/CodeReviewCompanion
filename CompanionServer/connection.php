<?php
$servername = "localhost:3306";
$username = "root";
$password = "";
$db="code_review_db";
// Create connection
$conn = mysqli_connect($servername, $username, $password,$db);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
?>