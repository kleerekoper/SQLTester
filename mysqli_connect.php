<?php 
DEFINE ('DB_USER', ''); 
DEFINE ('DB_PASSWORD', ''); 
DEFINE ('DB_HOST', '');
DEFINE ('DB_NAME', ''); 

$conn = @mysqli_connect (DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) OR die ('Could not connect to MySQL: ' . mysqli_connect_error() );
?>
