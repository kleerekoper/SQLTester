<?php 
if(!isset($_SESSION)){
    session_start();
}
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}


$page_title = 'Run Test';
include ('header.html');

require_once ('mysqli_connect.php');

// If we've got here via the View Tests page or after hitting submit (which is how we should get here) 
// then we load up the questions for this test instance
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $tid = $_POST['tid'];
    $testtime = $_POST['testtime'];
    $snumber = $_SESSION['snumber'];
    $testlength = $_SESSION['testlength'];
    $query = "SELECT * FROM admin_TestInstances WHERE T_id = $tid AND S_number = $snumber AND TestTime = \"$testtime\";";
    $results = @mysqli_query ($conn, $query);
    $questionids = array();
    $numberQuestions = 10;
    if ($results) {
        while ($row = mysqli_fetch_array($results, MYSQLI_BOTH)) {
            for( $i = 3; $i<3+$numberQuestions; $i++ ) {
                $questionids[] = $row[$i];
            }
        }
    }
    // if the student has loaded this page by clicking one of the questions then we have to load the chosen question
    // if not, then we have got here via the View Tests page and should load the first question
    if (isset($_POST['thisQuestion'])){
        $thisQuestion = $_POST['thisQuestion'];
    }else{
        $thisQuestion = $questionids[0];
        $_POST['thisQuestion'] = $thisQuestion;
    }

    // if the student clicked the submit button then we need to add their answer to the database and check if it's correct
    if (isset($_POST['userSQL'])){
        // in theory, the student can enable the submit button in their client, so here just check that they are still allowed to submit answers
        $timeleft = -1;
        $query = "SELECT TIMESTAMPDIFF(SECOND, now(), TestTime + INTERVAL testlength MINUTE) AS timeleft FROM admin_TestInstances INNER JOIN admin_Students USING($snumber) WHERE TestTime = $testtime;";
        $results = @mysqli_query ($conn, $query);
        if ($results){
            while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                $timeleft = $row['timeleft'];
            }
        }
        if ($timeleft >= 0){
            $modelAnswer = '';
            $query = "SELECT Answer FROM admin_Questions WHERE Q_id = $thisQuestion;";
            $results = @mysqli_query ($conn, $query);
            if ($results) {
                while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
                    $modelAnswer = $row['Answer'];
                }
            }
            // check if the answer is correct
            $studentAnswer = $_POST['userSQL'];
            require 'check_answer.php';
            $studentAnswer = filter_var($_POST['userSQL'], FILTER_SANITIZE_MAGIC_QUOTES);
        
            $query = "INSERT INTO admin_Answers VALUES($tid, $snumber, \"$testtime\", $thisQuestion, now(), \"$studentAnswer\", $correct);";
            $results = @mysqli_query ($conn, $query);
            if (!$results){
                echo "error inserting new answer";
                echo $query;
                echo mysqli_error($conn);
            }
        }
    }
}

// below is the countdown timer running via javascript
?>
<p></p>
<div id="clockdiv" align="center">
    <div>
        <span class="hours"></span>
        <div class="smalltext">&nbsp;Hours&nbsp;</div>
    </div>
    <div>
        <span class="minutes"></span>
        <div class="smalltext">Minutes</div>
    </div>
    <div>
        <span class="seconds"></span>
        <div class="smalltext">Seconds</div>
    </div>
</div>
<p></p>

<?php
// Add the buttons for the questions on the test
// Each button is a secret form that when clicked reloads this page but with a new question
echo "<nav class='questions'><ul>";
$numQuestions = 10;
for( $i = 1; $i<$numQuestions+1; $i++ ) {
    $color = 'ff7a7a';
    $index = $i-1;
    // change colour if question has been answered correctly already
    $query = "SELECT Correct FROM admin_Answers WHERE T_id = $tid AND S_number = $snumber AND TestTime = \"$testtime\" AND Question_id = $questionids[$index] ORDER BY AnswerTime DESC LIMIT 1;";
    $answers = @mysqli_query ($conn, $query);
    if ($answers) {
        while ($row = mysqli_fetch_array($answers, MYSQLI_ASSOC)) {
            if ($row['Correct']==1){
                $color = '36f41d';
            }
        }
    }
    echo '<form id = "question'.$questionids[$index].'" action="run_test.php" method="post">';
    echo '<input type="hidden" name="tid" id="hiddenField" value="'.$tid.'" />';
    echo '<input type="hidden" name="testtime" id="hiddenField" value="'.$testtime.'" />';
    echo '<input type="hidden" name="thisQuestion" id="hiddenField" value="'.$questionids[$index].'" />';
    // make the text larger and bold for the question currently being attempted
    if ($questionids[$index]==$thisQuestion){
        echo "<li onclick=\"question$questionids[$index].submit();\" style=\"font-weight:bold; font-size:100%; background:#$color;\">Question $i</li>";
    }else{
        echo "<li onclick=\"question$questionids[$index].submit();\" style=\"background:#$color;\">Question $i</li>";
    }
    echo '</form>';
}
echo '</ul></nav>';
?>

<div id="testbody">
<div id="divtopleft">
<br />
<br />
<h2>Question:</h2>
<?php
// Display the question the student is working on
$query = "SELECT Question FROM admin_Questions WHERE Q_id = $thisQuestion;";
$results = @mysqli_query ($conn, $query);
if ($results) {
    while ($row = mysqli_fetch_array($results, MYSQLI_BOTH)) {
        echo "$row[Question]";
    }
}
// Show a text box for the student to write their answer and submit it
?>
<div>
<form id="newanswerform" action="run_test.php" method="post">
<br />
<textarea style="font-size: 110%; resize: none;" rows="11" cols="60" id="userSQL" form="newanswerform" name="userSQL" onfocus="clearTextBox(this)">
<?php
// try and prefill the text box with the student's last attempt at this question
$query = "SELECT Answer FROM admin_Answers 
        WHERE T_id = $tid AND S_number = $snumber 
        AND TestTime = \"$testtime\" AND Question_id = $thisQuestion
        ORDER BY AnswerTime DESC LIMIT 1;";
$answers = @mysqli_query ($conn, $query);
if ($answers) {
    while ($row = mysqli_fetch_array($answers, MYSQLI_ASSOC)) {
        echo "$row[Answer]";
    }
}
// if the student has not attempted the question yet then display a default message
if (mysqli_num_rows($answers)==0){
    echo "Type your answer here.";
    echo mysqli_error($conn);
}
// below is the form to submit the answer as well as some hidden values
?>
</textarea>
<br />
<input type="hidden" name="tid" id="hiddenField" value="<?php echo $tid ?>" />
<input type="hidden" name="testtime" id="hiddenField" value="<?php echo $testtime ?>" />
<input type="hidden" name="thisQuestion" id="hiddenField" value="<?php echo $thisQuestion ?>" /> 
<input type="submit" class="myButton" value="Submit Answer" id="submit" />
</form>
</div>
</div>

<div id="divtopright">
<br />
<div>
    <p><h2>Database Tables</h2></p>
    <?php
        $sql = "SELECT T_schemaPic FROM admin_Tests WHERE T_id = $tid;";
        $result = @mysqli_query($conn,$sql);
        if ($result) {
            while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
                echo "<img src=\"$row[T_schemaPic]\"/>";
            }
        }
    ?>
</div>
</div>

<div id="divbottomleft">
<div>
    <p><h2>Output From Your Query:</h2></p>
    <?php
    // here show the output from the student's last answer so they can compare it to the desired output
    // the work is done in getsqlresults.php which formats the output nicely
    // if there was an error in the syntax then the error message is displayed
    $query = "SELECT * FROM admin_Answers WHERE T_id = $tid AND S_number = $snumber AND TestTime = \"$testtime\" AND Question_id = $thisQuestion ORDER BY AnswerTime DESC LIMIT 1;";
    $results = @mysqli_query ($conn, $query);
    if ($results) {
        while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
            $answer = $row['Answer'];
            require 'getsqlresults.php';
        }
    }
    ?>
</div>
</div>

<div id="divbottomright">
<div>
    <p><h2>Desired Output:</h2></p>
    <?php 
    // use getsqlresults.php to display the desired output
    $query = "SELECT Answer FROM admin_Questions WHERE Q_id = $thisQuestion;";
    $results = @mysqli_query ($conn, $query);
    if ($results) {
        while ($row = mysqli_fetch_array($results, MYSQLI_ASSOC)) {
            $answer = $row['Answer'];
            require 'getsqlresults.php';
        }
    }
    ?>
</div>
</div>
</div>


<script>
    // the javascript below makes the clock work
    function getTimeRemaining(endtime) {
        var t = Date.parse(endtime) - Date.parse(new Date());
        var seconds = Math.floor((t / 1000) % 60);
        if (seconds < 0){
            seconds = 0;
        }
        var minutes = Math.floor((t / 1000 / 60) % 60);
        if (minutes < 0){
            minutes = 0;
        }
        var hours = Math.floor(((t / 1000 / 60 / 60) % 60) );
        if (hours < 0){
            hours = 0;
        }
        return {
            'total': t,
            'hours': hours,
            'minutes': minutes,
            'seconds': seconds
            };
    }

    function initializeClock(id, endtime) {
        var clock = document.getElementById(id);
        var hoursSpan = clock.querySelector('.hours');
        var minutesSpan = clock.querySelector('.minutes');
        var secondsSpan = clock.querySelector('.seconds');

        function updateClock() {
            var t = getTimeRemaining(endtime);
            hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
            minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
            secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

            if (t.total <= 0) {
                clearInterval(timeinterval);
                disableSubmissions();
            }
        }

        updateClock();
        var timeinterval = setInterval(updateClock, 1000);
    }

    
    // Split timestamp into [ Y, M, D, h, m, s ]
    var t = "<?php echo $_POST['testtime'] ?>".split(/[- :]/);
    // Apply each element to the Date function
    var starttime = new Date(Date.UTC(t[0], t[1]-1, t[2], t[3], t[4], t[5]));
    //var deadline = new Date(Date.parse(new Date(starttime)) + 50 * 60 * 1000);
    var deadline = new Date(Date.parse(new Date(starttime)) + <?php echo $testlength ?> * 60 * 1000);
    initializeClock('clockdiv', deadline); 
    
    // if the student submitted an answer show an alert box telling them whether it was right or not
    // by the time we get here in the script, $correct will have been set above
    <?php 
    if (isset($_POST['userSQL'])){
        if ($correct == 0){
            echo 'alert("Unfortunately that answer was not correct. Keep trying!")';
        }
    }
    ?>
    
    // disable submission of new answers
    function disableSubmissions(){
        document.getElementById("submit").disabled = true;
    }
    
    // clear answer text box, on focus, if no answer has been tried
    function clearTextBox(obj){
        if (obj.value == "Type your answer here."){
            obj.value = '';
        }
    }
</script>
    
<?php    

mysqli_close($conn); 

//include ('footer.html');
?> 


