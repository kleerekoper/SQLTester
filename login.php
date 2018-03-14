<?php
if ($_SERVER["REQUEST_METHOD"] == "POST"){
	require_once ('check_login.php');
	require_once ('mysqli_connect.php');
		
	list($test, $data) = check_login($conn, $_POST['snumber'], $_POST['pass']);
	
	if ($test) {
		session_start();
		$_SESSION['snumber'] = $data['S_number'];
		$_SESSION['first_name'] = $data['S_firstName'];
        $_SESSION['testlength'] = $data['testlength'];
        $_SESSION['admin'] = $data['is_admin'];
        
		header("Location: loggedin.php");
		exit(); 
	} else { 
		$errors = $data;
	}
mysqli_close($conn); 
}
include('login_page.php');
?>
