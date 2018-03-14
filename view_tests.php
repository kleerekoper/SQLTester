<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}
$page_title = 'View Tests';
include ('header.html');

echo '<h3>Started Tests</h3>';

require_once ('mysqli_connect.php'); 
		
$query = "SELECT admin_TestInstances.T_id, TestTime, T_name, TestTime + INTERVAL testlength MINUTE AS EndTime FROM admin_TestInstances JOIN admin_Tests USING(T_id) JOIN admin_Students USING(S_number) WHERE S_number = $_SESSION[snumber] ORDER BY TestTime DESC;";
$results = @mysqli_query ($conn, $query);

$numrows = mysqli_num_rows($results);

if ($results) {
	if ($numrows >0) {
		echo '<table>
            <tr><td><strong>Test Name</stong></td>
            <td><strong>Date Started</stong></td>
            <td><strong>Time Remaining</stong></td>
            <td><strong>Current Score</stong></td>
            <td></td></tr>';
			while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                $score = 0;
                $query2 = "SELECT DISTINCT a.S_number, a.TestTime, SUM(Correct) AS Total, T_name
                            FROM admin_Answers a
                            INNER JOIN admin_Tests ON a.T_id = admin_Tests.T_id
                            WHERE S_number = $_SESSION[snumber]  AND TestTime = \"$row[TestTime]\"
                            AND AnswerTime = (SELECT a1.AnswerTime 	
                                    FROM admin_Answers a1 
                                    WHERE a1.Question_id = a.Question_id 
                                    AND a1.S_number = $_SESSION[snumber] 
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
                $timeremaining = strtotime($row['EndTime']) - time();
                $minutesremaining = round($timeremaining / 60);
                $secondsremaining = round($timeremaining % 60);
                if ($timeremaining < 0){
                    $minutesremaining = 00;
                    $secondsremaining = 00;
                }
                echo '<tr><td>' . $row['T_name'] . '</td><td>' . $row['TestTime'] . '</td><td align="right">' . $minutesremaining.':'.$secondsremaining . '</td><td align="right">' . $score . '</td>
                <td><form action="run_test.php" method="post">
                <input type="hidden" name="tid" id="hiddenField" value="'.$row['T_id'].'" />
                <input type="hidden" name="testtime" id="hiddenField" value="'.$row['TestTime'].'" />
                <input type="submit" name="submit" value="View Test" />
                </form></td></tr>';
            }
		echo '</table>'; 
	
		mysqli_free_result ($results);	
	} else {
		echo '<p class="error">There are no started tests.</p>';
	}
} else { 
	echo '<h3 class="error">System Error</h3>
	<p class="error">User data could not be retrieved.</p>';
} 

mysqli_close($conn); 

include ('footer.html');
?> 

