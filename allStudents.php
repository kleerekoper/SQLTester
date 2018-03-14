<?php

echo '<h3>Registered Students</h3>';

require_once ('mysqli_connect.php'); 
		
$query = "SELECT S_number, CONCAT(S_firstName, ' ', S_surname) AS Name, testlength FROM admin_Students;";
$results = @mysqli_query ($conn, $query);

$numrows = mysqli_num_rows($results);

if ($results) {
	if ($numrows >0) {
		echo '<p>There are ' . $numrows . ' registered students;</p>';
		echo '<table>
            <tr><td><strong>Student Number</strong></td>
            <td><strong>Name</strong></td>
            <td><strong>Test Length</strong></td><td></td></tr>';
			while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                echo '<tr><td>' . $row['S_number'] . '</td><td>' . $row['Name'] . '</td><td>' . $row['testlength'] . '</td>';
                echo '<td><form action="admin.php" method="post">
                <input type="hidden" name="reportName" id="hiddenField" value="Scores" />
                <input type="hidden" name="snum" id="hiddenField" value="'.$row['S_number'].'" />
                <input type="submit" name="submit" value="View Tests" />
                </form></td></tr>';
            }
		echo '</table>'; 
	
		mysqli_free_result ($results);	
	} else {
		echo '<p class="error">There are no registered students.</p>';
	}
} else { 
	echo '<h3 class="error">System Error</h3>
	<p class="error">Student data could not be retrieved.</p>';
} 

mysqli_close($conn); 


?>