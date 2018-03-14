<?php 
function check_login($conn, $snumber = '', $passin = '') {
	$errors = array(); 
	if (empty($snumber)) {
		$errors[] = 'You forgot to enter your student number.';
	} else {
		$snumber = mysqli_real_escape_string($conn, trim($snumber));
	}
	if (empty($passin)) {
		$errors[] = 'You forgot to enter your password.';
	} else {
		$pass = mysqli_real_escape_string($conn, trim($passin));
	}
      
	if (empty($errors)) { 
		$query = "SELECT S_number, S_firstName, testlength, is_admin FROM admin_Students WHERE S_number='$snumber' AND S_password=SHA1('$pass')";	
		$results = @mysqli_query ($conn, $query);

		if (mysqli_num_rows($results) == 1) {
			$row = mysqli_fetch_array ($results, MYSQLI_ASSOC);
			return array(true, $row);
		
        } else { 
			$errors[] = 'The entered student number and password are incorrect.';
		}
	} 
	return array(false, $errors);
} 
?>
