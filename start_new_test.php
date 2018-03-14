<?php 
session_start();
if (!isset($_SESSION['snumber'])) {
	header("Location: 	restricted.php");
	exit(); 
}

$page_title = 'Start New Test';
include ('header.html');

echo '<h3>Select Test</h3>';
if ($_SESSION['correctPassword'] === False) {
	echo '<h2 class="error">Incorrect Password</h2>';
}

require_once ('mysqli_connect.php');

echo '<div id="placeholder">';
echo '<br /><form action="create_new_test.php" method="post">';

$query = "SELECT T_name, T_id FROM admin_Tests";
$result = @mysqli_query ($conn, $query);
if ($result === false) {
    echo mysql_error();
}

if(mysqli_num_rows($result)){
    $select= '<p><select id="select" name="tname" onchange="showTest(this.value)">';
    while($rs=mysqli_fetch_array($result)){
        $select.='<option value="'.$rs['T_name'].'">'.$rs['T_name'].'</option>';
    }
}
$select.='</select></p>';
echo $select;
?>

<p id="pic_placeholder"><img src="Computer-store-db.png"/></p>

<p>Password:  <input type="text" name="pass" size="30" 	maxlength="30" /></p>
<p></p>
<input type="submit" value="Start Test" id="submit">
</form>
</div>
<br />

<script>
function showTest(str) {
    if (str == "") {
        document.getElementById("placeholder").innerHTML = "";
        return;
    } else { 
        if (window.XMLHttpRequest) {
            // code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        } else {
            // code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                //document.getElementById("placeholder").innerHTML = this.responseText;
                document.getElementById("pic_placeholder").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("GET","getpicture.php?choice="+str,true);
        xmlhttp.send();
    }
}
</script>

<?php    
mysqli_close($conn); 

include ('footer.html');
?> 

