<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	index.php");
	exit();
} else { 
	$_SESSION=array();
	session_destroy();
	setcookie ('PHPSESSID', null);
}

$page_title = 'Logged Out';
include ('header.html');

echo "<h3>Successfully logged out.</h3>
<p>You are now logged out.</p>";

include ('footer.html');
?>
