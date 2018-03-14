<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	index.php");
	exit(); 
}
$page_title = 'Logged In';
include ('header.html');

echo "<h3>Successfully logged in.</h3>
<p>Welcome {$_SESSION['first_name']}, you are now logged in.</p>
<p><a href=\"logout.php\">Logout</a></p>";

include ('footer.html');
?> 
