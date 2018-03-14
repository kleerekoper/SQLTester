<?php

require_once ('mysqli_connect.php'); 

$query = "SELECT S_firstName, S_surname FROM admin_Students WHERE S_number = $_POST[snum];";
$results = @mysqli_query ($conn, $query);
$numrows = mysqli_num_rows($results);
if ($results) {
	if ($numrows >0) {
        while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
            echo "<h3>All Tests for $row[S_firstName] $row[S_surname]</h3>";
        }
    }
}

$query = "SELECT admin_TestInstances.T_id, TestTime, T_name, TestTime + INTERVAL testlength MINUTE AS EndTime FROM admin_TestInstances JOIN admin_Tests USING(T_id) JOIN admin_Students USING(S_number) WHERE S_number = $_POST[snum] ORDER BY TestTime DESC;";

$results = @mysqli_query ($conn, $query);
$numrows = mysqli_num_rows($results);

if ($results) {
	if ($numrows >0) {
		echo '<table>
            <tr><td><strong>Test Name</stong></td>
            <td><strong>Time Started</stong></td>
            <td><strong>Current Score</stong></td>
            </tr>';
			while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                $score = 0;
                $query2 = "SELECT DISTINCT a.S_number, a.TestTime, SUM(Correct) AS Total, T_name
                            FROM admin_Answers a
                            INNER JOIN admin_Tests ON a.T_id = admin_Tests.T_id
                            WHERE S_number = $_POST[snum]  AND TestTime = \"$row[TestTime]\"
                            AND AnswerTime = (SELECT a1.AnswerTime 	
                                    FROM admin_Answers a1 
                                    WHERE a1.Question_id = a.Question_id 
                                    AND a1.S_number = $_POST[snum] 
                                    AND a1.TestTime = \"$row[TestTime]\" 
                                    ORDER BY a1.AnswerTime DESC 
                                    LIMIT 1)
                            GROUP BY S_number, TestTime;";
                $results2 = @mysqli_query ($conn, $query2);
                if ($results2) {
                    $numrows2 = mysqli_num_rows($results2);
                    if ($numrows2 > 0){
                        while ($row2 = mysqli_fetch_array($results2, MYSQLI_ASSOC)){
                            if (is_null($row2['Total'])){
                                $score = 0;
                            }else{
                                $score = $row2['Total'];
                            }
                        }
                    }
                }
                echo '<tr><td>' . $row['T_name'] . '</td><td>' . $row['TestTime'] . '</td><td align="right">' . $score . '</td></tr>';
            }
		echo '</table>'; 
	
		mysqli_free_result ($results);	
	} else {
		echo '<p class="error">There are no started tests for this student.</p>';
	}
} else { 
	echo '<h3 class="error">System Error</h3>
	<p class="error">User data could not be retrieved.</p>';
} 
mysqli_close($conn); 


?>