<?php

include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");

$template = new Template;
include("templates/template-header.html");


echo "<table>\n";

if(isset($_POST["fund"]) && $_POST['fund'] != 0 && isset($_POST["organization"]) && $_POST['organization'] != 0 && isset($_POST["program"]) && $_POST['program'] != 0){
	$owner1 = $_POST["owner1"];
	$owner2 = $_POST["owner2"];
	$owner3 = $_POST["owner3"];	
	$fund = $_POST['fund'];
	$organization = $_POST['organization'];
	$program = $_POST['program'];
	$description = $_POST["description"];
	$date = date("Y-m-d");
	if(isset($_POST['closed']) && $_POST['closed'] == 'on')
		$closed = date("Y-m-d");
	else
		$closed = '0000-00-00';
	if(isset($_POST['submit']) && $_POST['submit'] == 'update'){
		$query = "UPDATE finance_account SET owner1='$owner1',owner2='$owner2',owner3='$owner3',fund='$fund',organization='$organization',program='$program',description='$description', date_closed='$closed' WHERE account_id=" . $_POST['id'];
	}
	else{
		$query = "INSERT INTO finance_account (owner1,owner2,owner3,fund,organization,program,description,date_open) VALUES ('$owner1','$owner2','$owner3','$fund','$organization','$program','$description','$date')";
	}
	$result = mysql_query($query) or die(mysql_error());
	
	echo"<meta http-equiv=refresh content=\"0; url=finance_main.php\">";
}

if(isset($_GET['view']) && $_GET['view'] == "edit" && isset($_GET['id'])){
	$query = "SELECT * FROM finance_account WHERE account_id = " . $_GET['id'];
	$selected = mysql_query($query);
	$select = mysql_fetch_array($selected);
	
	echo "<form name='input' action='account.php' method='post'>"; 
	$query = "SELECT first_name, last_name, user_id FROM `users` WHERE 1 ORDER BY `last_name`";
	$result = mysql_query($query) or die(mysql_error());
	
	echo "<tr><td>Owner 1</td><td><select name='owner1'>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'";
			if($select['owner1'] == $row['user_id']){echo" selected='selected'";}
			echo ">" . $row['last_name'] . ", " .$row['first_name'] ."</option>";}
	echo "</select></td>";
	
	mysql_data_seek($result,0);
	echo "<tr><td>Owner 2</td><td><select name='owner2'><option value=''></option>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'";
			if($select['owner2'] == $row['user_id']){echo" selected='selected'";}
			echo ">" . $row['last_name'] . ", " .$row['first_name'] ."</option>";}
	echo "</select></td></tr>";
	
	mysql_data_seek($result,0);
	echo "<tr><td>Owner 3</td><td><select name='owner3'><option value=''></option>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'";
			if($select['owner3'] == $row['user_id']){echo" selected='selected'";}
			echo ">" . $row['last_name'] . ", " .$row['first_name'] ."</option>";}
	echo "</select></td></tr>";


	echo "<tr><td>Fund</td><td><input type='text' name='fund' value='" . $select['fund'] . "'></td></tr>\n
	<tr><td>Organization</td><td><input type='text' name='organization' value='" . $select['organization'] . "'></td></tr>\n
	<tr><td>Program</td><td><input type='text' name='program' value='" . $select['program'] . "'></td></tr>\n
	<tr><td valign='top'>Description:</td><td><textarea name='description' rows='10' cols='90'>" . $select['description'] . "</textarea></td></tr>\n
	<tr><td></td><td><input type='checkbox' name='closed' ";
	if($select['date_closed'] != '0000-00-00') 
		echo "checked='checked' onclick='return false' onkeydown='return false'";  
	echo ">Closed</td></tr>\n
	<input type='hidden' name='id' value='" . $_GET['id'] . "'>
	<tr><td></td><td><input type='submit' value='update' name='submit' />&nbsp;&nbsp; <button type='button' onClick=window.location='finance_main.php'>Back to main</button></tr></table>
</form>";
}

else if(isset($_GET['view']) && $_GET['view'] == "reconciled" && isset($_GET['id'])){
	echo " <a href='account.php?view=reconciled&id=" . $_GET['id'] . "&show=all'>Show all</a>";

	if(isset($_GET['show']) && $_GET['show'] == 'all')
		$query = "SELECT * FROM finance_entry WHERE account_id=" . $_GET['id'];	
	else
		$query = "SELECT * FROM finance_entry WHERE account_id=" . $_GET['id'] . " AND reconciled_flag = 0";
	$result = mysql_query($query);

echo "<form name='finance_entry_edit' action='finance_entry_edit.php' method='post'>";
echo "<table class='sortable' border='1' cellpadding='3' style='border-collapse: collapse' bordercolor='#FFFFFF' cellspacing='1'>
    <tr height='30' bgcolor='#000000'>
                <th><b style='color:#E1E1E1;font-size:10px'>Transaction date</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Amount</b></th>
                <th width='400'><b style='color:#E1E1E1;font-size:10px'>Description</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Advance</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Reconciled</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Category</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Category</b></th>				
        </tr>";
	while($row = mysql_fetch_array($result)){
		echo "<tr onClick=\"javascript:document.location.href='finance_entry.php?view=edit&entry_id=" . $row['id'] . "'\" bgcolor='#D7D7D9'><td>" . convert_date_to_dmY($row['date_entered']) . "</td><td>$" . $row['ammount'] . "</td><td>" . $row['description'] . "</td>";
//		echo "<tr onClick='javascript:reconcileme(" . $row['ammount'] . "," . $row['id'] . "," . $_GET['id'] . ")' bgcolor='#D7D7D9'><td>" . convert_date_to_dmY($row['date_entered']) . "</td><td>$" . $row['ammount'] . "</td><td>" . $row['description'] . "</td>";
        if($row['advance_flag']==1)
                echo "<td bgcolor='#33FF33'></td>";
        else
                echo "<td></td>";
        if($row['reconciled_flag']==1)
                echo "<td bgcolor='#33FF33'></td>";
        else
                echo "<td></td>";
        echo "<td>" . $row['category_activity'] . "</td>";
}
	echo "<input type='hidden' name='amount' value=''>
  <input type='hidden' name='entry_id' value=''>
  <input type='hidden' name='account_id' value=''>";
  
echo "</form>";
echo "</table>";
}

else if(isset($_GET['view']) && $_GET['view'] == 'add'){
	echo "<form name='input' action='account.php' method='post'>"; 
	$query = "SELECT first_name, last_name, user_id FROM `users` WHERE 1 ORDER BY `last_name`";
	$result = mysql_query($query) or die(mysql_error());
	
	echo "<table>";
	echo "<tr><td>Owner 1 </td><td><select name='owner1'>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'>" . $row['user_id'] . " - " . $row['first_name'] . " " . $row['last_name'] . "</option>";}
	echo "</select></td></tr>";
	
	mysql_data_seek($result,0);
	echo "<tr><td>Owner 2 </td><td><select name='owner2'><option value=''></option>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'>" . $row['user_id'] . " - " . $row['first_name'] . " " . $row['last_name'] . "</option>";}
	echo "</select></td></tr>";
	
	mysql_data_seek($result,0);
	echo "<tr><td>Owner 3 </td><td><select name='owner3'><option value=''></option>";
	while($row = mysql_fetch_array($result)){
			echo "<option value='" . $row['user_id'] . "'>" . $row['user_id'] . " - " . $row['first_name'] . " " . $row['last_name'] . "</option>";}
	echo "</select></td></tr>";
	
	echo "<tr><td>Fund </td><td><input type='text' name='fund'></td></tr>
	<tr><td>Organization </td><td><input type='text' name='organization'></td></tr>
	<tr><td>Program </td><td><input type='text' name='program'></td></tr>
	<tr><td></td><td><textarea onclick='document.input.description.value =\"\";' name='description' rows='10' cols='90'>Description</textarea></td></tr>
	<tr><td><input type='submit' value='submit' /></td></tr>
	</table>
</form>";
}

else if (isset($_GET['view']) && $_GET['view'] == "unreconciled")
{
	$query = "SELECT * FROM finance_entry WHERE reconciled_flag = 0";
	$return = "account.php?view=unreconciled";

	make_table($query,$return);
}

else if (isset($_GET['view']) && $_GET['view'] == "advances")
{
	$query = "SELECT * FROM finance_entry WHERE advance_flag = 1";
	$return = "account.php?view=advances";

	make_table($query,$return);
}

else if (isset($_GET['view']) && $_GET['view'] == "overdue")
{
	$query = "SELECT DISTINCT * FROM finance_entry WHERE id IN (SELECT id FROM (SELECT TIMESTAMPDIFF(DAY, NOW(), `transaction_date`) AS 'days_gone' , id AS id FROM finance_entry WHERE `date_reconciled` = 0000-00-00) AS overdue WHERE days_gone < -29)";
	$return = "account.php?view=overdue";

	make_table($query,$return);
}

else
	echo"<meta http-equiv=refresh content=\"0; url=finance_main.php\">";

include("templates/template-footer.html");

function get_name($user_id)
{
	if($user_id == 0){
		$first_name = "";$last_name = "";
	}
	else{
		$query = "SELECT first_name, last_name FROM `users` WHERE user_id='" . $user_id . "'";
		$result = mysql_query($query) or die(mysql_error());
		$first_name = mysql_result($result,0);
		$last_name = mysql_result($result,0,1);
	}
	return $first_name . " " . $last_name;
}

function make_table($query, $return)
{
	$result = mysql_query($query);

	echo "<link rel='stylesheet' type='text/css' href='/includes/datechooser.css'>";

	echo "<form name='finance_entry_edit' action='finance_entry_edit.php' method='post'>";
	echo "<table class='sortable' border='1' cellpadding='3' style='border-collapse: collapse' bordercolor='#FFFFFF' cellspacing='1'>
    <tr height='30' bgcolor='#000000'>
				<th><b style='color:#E1E1E1;font-size:10px'>Program</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Transaction date</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Amount</b></th>
                <th width='400'><b style='color:#E1E1E1;font-size:10px'>Description</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Advance</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Reconciled</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Category</b></th>
                <th><b style='color:#E1E1E1;font-size:10px'>Category</b></th>				
        </tr>";
	while($row = mysql_fetch_array($result)){
		echo "<tr onClick='javascript:reconcileme(" . $row['ammount'] . "," . $row['id'] . "," . $row['account_id'] . ")' bgcolor='#D7D7D9'><td>" . return_program($row['account_id']) . "</td><td>" . convert_date_to_dmY($row['date_entered']) . "<img src='/admin/includes/calendar.gif'  align='absmiddle' onclick='showChooser(this, \"transaction_date\", \"chooserSpan\", 2011, 2020, \"d/m/Y\", false);return false;'>
<div id='chooserSpan' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'>
</div></td><td>$" . $row['ammount'] . "</td><td>" . $row['description'] . "</td>";
        if($row['advance_flag']==1)
                echo "<td bgcolor='#33FF33'></td>";
        else
                echo "<td></td>";
        if($row['reconciled_flag']==1)
                echo "<td bgcolor='#33FF33'></td>";
        else
                echo "<td></td>";
        echo "<td>" . $row['category_activity'] . "</td>";
	}
	echo "<input type='hidden' name='amount' value=''>
  <input type='hidden' name='entry_id' value=''>
  <input type='hidden' name='account_id' value=''>
  <input type='hidden' name='return_to' value='" . $return . "'>";
  
echo "</form>";
echo "</table>";
echo "<form>";
echo "<input type='hidden' name='transaction_date' id='transaction_date' value=''>";
echo "<img src='/admin/includes/calendar.gif'  align='absmiddle' onclick='showChooser(this, \"transaction_date\", \"chooserSpan\", 2011, 2020, \"d/m/Y\", false);'>
<div id='chooserSpan' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'>
</div></form>";
}

function convert_date_to_dmY($date){
	$date_array = explode("-",$date);
	$year = $date_array[0];
	$month = $date_array[1];
	$day = $date_array[2];		
	
	return $day . "/" . $month . "/" . $year;
}

function return_program($account_id){
	$query = "SELECT `program` FROM finance_account WHERE `account_id` = " . $account_id;
	$result = mysql_query($query);
	$row = mysql_fetch_array($result);
	return $row[0];
}
?>
