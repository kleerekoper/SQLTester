<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}
$page_title = 'Administration';
include ('header.html');

?>

<section id="maincontent">
<h3>Select Report</h3>
<div id="placeholder">
<br />
<form action="admin.php" method="post" id="OptionForm">
<p><select id="select" name="reportName" onchange="showTextBox()">
    <option value="Users">All Students</option>
    <option value="Scores">All Student's Scores</option>
    <option value="SpecificTest">All Test's Scores</option>
    </select>    
<input type="text" name="snum" id="snum" placeholder="Student Number" style="display:none;">    
<input type="submit" value="Report" id="submit">
</form>
<p>
<h4 class="error" id="Warning" style="display:none;">Warning: This page may take a few seconds to load</h4>
</div>
<br />

<script>
function showTextBox(str){
    str = document.getElementById("select").value;
    if (str == 'Users'){
        document.getElementById("snum").style.display='none';
    }else {
        document.getElementById("snum").style.display='inline';
        if (str == "SpecificTest"){
            document.getElementById("snum").placeholder='Test ID';
            document.getElementById("Warning").style.display='inline';
        }else{
            document.getElementById("snum").placeholder='Student Number';
            document.getElementById("Warning").style.display='none';
        }
    }
    if (str == "SpecificTest"){
        document.getElementById("Warning").style.display='inline';
    }else{
        document.getElementById("Warning").style.display='none';
    }
}
</script>


<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if ($_POST["reportName"] === "Users"){
        include 'allStudents.php';
    }elseif ($_POST["reportName"] === "Scores"){
        include 'allScores.php';
    }elseif ($_POST["reportName"] === "SpecificTest"){
        include 'specificTest.php';
    }
}

include ('footer.html');
?> 

