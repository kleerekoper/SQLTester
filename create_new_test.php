<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}

require_once ('mysqli_connect.php');

// get test id
$query = 'SELECT T_id FROM admin_Tests WHERE T_name = "'.$_POST['tname'].'";';
$results = @mysqli_query($conn, $query);
$numrows = mysqli_num_rows($results);
$tid = '';
while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
    $tid = $row['T_id'];
}

// check test password is correct
$correctPassword = True;
$pass = $_POST['pass'];
$query = "SELECT T_id FROM admin_TestPasswords WHERE T_id = $tid AND Password = SHA1('$pass');";
$results = @mysqli_query($conn, $query);
if (mysqli_num_rows($results) == 0) {   
    $correctPassword = False;
}

// create a new test instance by selecting random questions from the relevant categories and banks
if ($correctPassword){
    $testtime = date('Y-m-d H:i:s');
    // ten questions in total - two inner join questions
    $questionIDQuery = "(SELECT Q_id FROM admin_Questions WHERE Category = 'OneTableSelect' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'OneTableSelectWhere' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'OneTableSelectOrder' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'RowFunction' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'GroupFunction' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'InnerJoin' AND T_id = $tid ORDER BY RAND() LIMIT 2)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'GroupBy' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'GroupByHaving' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    UNION
    (SELECT Q_id FROM admin_Questions WHERE Category = 'SimpleSubquery' AND T_id = $tid ORDER BY RAND() LIMIT 1)
    ORDER BY RAND();";

    $results = @mysqli_query ($conn, $questionIDQuery);
    $query = "INSERT INTO admin_TestInstances VALUES ($tid, $_SESSION[snumber], \"$testtime\",";

    $numberQuestions = 10;
    if ($results){
        for ($i = 0; $i < $numberQuestions; $i++) {
            $query = $query.mysqli_fetch_row($results)[0];
            if ($i < $numberQuestions - 1){
                $query = $query.',';
            }
        }
            $query = $query.');';
    }else{
        include ('header.html');
        echo '<h3>Creating New Test</h3>';
        echo '<p>There was an error creating the new test<br />';
        echo mysqli_error($conn).'<br />';
        echo $query.'</p>';
        mysqli_close($conn); 
        include ('footer.html'); 
    }

    $results = @mysqli_query ($conn, $query);
    if ($results) {
        $_POST['tid'] = $tid;
        $_POST['testtime'] = $testtime;
        include 'run_test.php';
    }else{
        include ('header.html');
        echo '<h3>Creating New Test</h3>';
        echo '<p>There was an error creating the new test<br />';
        echo mysqli_error($conn).'<br />';
        echo $query.'</p>';
        mysqli_close($conn); 
        include ('footer.html');
    }    
}else{
    $_SESSION['correctPassword'] = False;
    header('Location: start_new_test.php');
}
?> 

