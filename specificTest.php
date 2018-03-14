<?php

require_once ('mysqli_connect.php'); 

$testname = "";
$query = "SELECT T_name FROM admin_Tests WHERE T_id = $_POST[snum];";
$results = @mysqli_query ($conn, $query);
$numrows = mysqli_num_rows($results);
if ($results) {
	if ($numrows >0) {
        while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
            echo "<h3>All Scores for $row[T_name]</h3>";
        }
    }else { 
        echo '<h3 class="error">System Error</h3>
        <p class="error">No Such Test</p>';
}
} 

$query = "SELECT CONCAT (S_firstName, ' ', S_surname) AS Name, a.S_number, a.TestTime, SUM(Correct) AS Mark
        FROM admin_Answers a
        INNER JOIN admin_Tests ON a.T_id = admin_Tests.T_id
        INNER JOIN admin_Students USING(S_number)
        WHERE a.T_id = $_POST[snum]
        AND AnswerTime IN (SELECT MAX(a1.AnswerTime) FROM admin_Answers a1 WHERE a1.S_number = a.S_number AND a1.TestTime = a.TestTime GROUP BY a1.Question_id)
        GROUP BY S_number, TestTime
        ORDER BY S_number;";

$results = @mysqli_query ($conn, $query);
$numrows = mysqli_num_rows($results);


if ($results) {
	if ($numrows >0) {
        echo '<p>There are ' . $numrows . ' test scores;</p>';
		echo '<table>
            <tr><td><strong>Student Name</strong></td>
            <td><strong>Student Number</strong></td>
            <td><strong>Test Time</strong>
            <td><strong>Score</strong></td>
            </tr>';
			while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                echo '<tr><td>' . $row['Name'] . '</td><td>' . $row['S_number'] . '</td><td>' . $row['TestTime'] . '</td><td align="right">' . $row['Mark'] . '</td></tr>';
            }
		echo '</table>'; 
		mysqli_free_result ($results);	
	} else {
		echo '<p class="error">There are no scores for this test.</p>';
	}
} else { 
	echo '<h3 class="error">System Error</h3>
	<p class="error">User data could not be retrieved.</p>';
} 

mysqli_close($conn); 


?>