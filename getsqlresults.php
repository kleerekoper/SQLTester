<!DOCTYPE html>
<html>
<head>
<style>
table {
    width: 100%;
    border-collapse: collapse;
}

table, td, th {
    border: 1px solid black;
    padding: 5px;
}

th {text-align: left;}
</style>
</head>
<body>

<?php
if (isset($_GET['q'])){
    $q = $_GET['q'];
}

if (isset($answer)){
    $q = $answer;
}

$result = @mysqli_query($conn,$q);

// If the sql query contains a syntax error, display the error message from MySQL 
if ($result == false) {
    echo "<p><b>There was an error in your answer:<br /></b>";
    echo mysqli_errno($conn).": ".mysqli_error($conn)."</p>";
    return;
}


$numberCols = mysqli_num_fields ($result);

echo "<table>
<tr>";

for ($i = 0; $i < $numberCols; $i++) {
    $finfo = mysqli_fetch_field_direct($result, $i);
    echo "<th style=\"text-align:center;\">" . $finfo->name . "</th>";
}
echo "</tr>";

while($row = mysqli_fetch_array($result)) {
    echo "<tr>";
    for ($i = 0; $i < $numberCols; $i++) {
        echo "<td style=\"text-align:left;\">" . $row[$i] . "</td>";
    }
    echo "</tr>";
}
echo "</table>";

if (!isset($answer)){
mysqli_close($conn); 
}
?>
</body>
</html>