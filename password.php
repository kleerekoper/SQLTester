<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}
$page_title = 'Change Password';
include ('header.html');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	require_once ('mysqli_connect.php');
		
	$errors = array();
	
	if (empty($_POST['snumber'])) {
		$errors[] = 'You forgot to enter your student number.';
	} else {
		$snumber = mysqli_real_escape_string($conn, trim($_POST['snumber']));
	}
	if (empty($_POST['pass'])) {
		$errors[] = 'You forgot to enter your current password.';
	} else {
		$pass = mysqli_real_escape_string($conn, trim($_POST['pass']));
	}
	if (!empty($_POST['pass1'])) {
		if ($_POST['pass1'] != $_POST['pass2']) {
			$errors[] = 'Your passwords did not match.';
		} else {
			$newpass = mysqli_real_escape_string($conn, trim($_POST['pass1']));
		}
	} else {
		$errors[] = 'You forgot to enter your new password.';
	}
if (empty($errors)) {
		$query = "SELECT S_number FROM admin_Students WHERE (S_number=$snumber AND S_password=SHA1('$pass'))";
		$results = @mysqli_query($conn, $query);
		$numrows = @mysqli_num_rows($results);
		if ($numrows == 1) { 
			$row = mysqli_fetch_array($results, MYSQLI_NUM);
			$query = "UPDATE admin_Students SET S_password=SHA1('$newpass') WHERE S_number=$row[0]";		
			$results = @mysqli_query($conn, $query);
			
			if (mysqli_affected_rows($conn) == 1) {
				echo '<h3>Thank you!</h3>
				<p>Your password has been changed.</p>';	
			} else { 
				echo '<h3>System Error</h3>
				<p class="error">Your password could not be changed due to a system error.</p>'; 
			}
			include ('footer.html'); 
			exit();
		} else {
			echo '<h3>Error</h3>
			<p class="error">The entered student number and password are incorrect.</p>';
		}
	} else {
        echo '<h3>Error</h3>
        <p class="error">The following error(s) occurred:</p>';
        foreach ($errors as $message) {
            echo "<p class='error'>$message</p>";
        }
        echo '<p>Please try again.</p>';
    } 
	mysqli_close($conn); 
} 
?>

<h3>Change Your Password</h3>
<form action="password.php" method="post">
	<p><label>Student Number: </label><input type="text" name="snumber" size="20" maxlength="20" 
        value="<?php if (isset($_POST['snumber'])) echo $_POST['snumber']; ?>"/> </p>
	<p><label>Current Password: </label><input type="password" name="pass" size="20" maxlength="20" /></p>
	<p><label>New Password: </label><input type="password" name="pass1" size="20" maxlength="20" /></p>
	<p><label>Confirm New Password: </label><input type="password" name="pass2" size="20" maxlength="20" /></p>
	<p><input type="submit" name="submit" value="Change Password" /></p>
</form>
<?php
include ('footer.html');
?>
