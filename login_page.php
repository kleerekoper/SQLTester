<?php
$page_title = 'Login';
include ('header.html');

if (!empty($errors)) {
	echo '<h3 class="error">Error</h3>
	<p class="error">The following error(s) occurred:</p>';
	foreach ($errors as $message) {
		echo '<p class="error">' . $message . '</p>';
	}
	echo '<p>Please try again.</p>';
}
?>

<h3>Login</h3>
<form action="login.php" method="post">
	<p><label>Student Number: </label><input type="text" name="snumber" size="20" maxlength="20" /> </p>
	<p><label>Password: </label><input type="password" name="pass" size="20" 	maxlength="20" /></p>
	<p><input type="submit" name="submit" value="Login" /></p>
</form>
<?php include ('footer.html'); ?>
