<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");
//include("includes/garbage_collector.php");
$template = new Template;
//require("security.php");

include("html/header.html");

$success="";
//echo"<pre>";
//print_r($_POST);
//print_r($_GET); 
//echo"</pre>";
if(isset($_REQUEST['action'])) if(isset($_REQUEST['add']) || isset($_REQUEST['update']) || $_REQUEST['action']=="add_date_add" || $_REQUEST['action']=="add_date_update") {
	
	$topics = (isset($_REQUEST['topics']))?$topics = implode(",", $_REQUEST['topics']): "";
	if(!isset($_REQUEST['approved'])) $approved = "no"; else $approved='yes';
	if(!isset($_REQUEST['internal'])) $internal = "no"; else $internal='yes';
}

if(isset($_REQUEST['action'])) if(isset($_REQUEST['add']) || $_REQUEST['action']=="add_date_add") {
	//only one date for an ADD
	$tmp_date = explode("/", $_REQUEST['d_date']);
	$d_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	$tmp_date = explode("/", $_REQUEST['close_warning_date']);
	$close_warning_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	$tmp_date = explode("/", $_REQUEST['early_warning_date']);
	$early_warning_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	if ($_REQUEST['expiry_date'] != "") {
		$tmp_date = explode("/", $_REQUEST['expiry_date']);
		$expiry_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	}
	if(!is_numeric($_REQUEST['days_in_advance'])) $days_in_advance=0; else $days_in_advance=$_REQUEST['days_in_advance'];
	if(isset($_REQUEST['override'])) $override=TRUE; else $override=FALSE;// flag for don't email deadline
    if(isset($_REQUEST['no_deadline'])) $no_deadline=TRUE; else $no_deadline=FALSE;
	$values = array('null', addslashes($_REQUEST['title']), addslashes($_REQUEST['warning_message']), addslashes($_REQUEST['description']), addslashes($_REQUEST['synopsis']), $topics, $approved, $internal,$override,$no_deadline);
	if(mysqlInsert("deadlines", $values)) $success=" <strong>Complete</strong>";
	$id=mysql_insert_id();
	$values = array('null',$id,$d_date,$close_warning_date, $early_warning_date, $expiry_date,$days_in_advance);
	if(mysqlInsert("deadline_dates", $values)) $success=" <strong>Complete (1 date)</strong>";
	//add a date entry by repeating the entry (can't use zero or dates get weird)
	if($action=="add_date_add"){
		if(mysqlInsert("deadline_dates", $values)) $success=" <strong>Complete (1 date)</strong>";
		$section='update';
	}
}
else if(isset($_REQUEST['action'])) if (isset($_REQUEST['update']) || $_REQUEST['action']=="add_date_update") {
	
	$dates=mysqlFetchRows("deadline_dates","deadline_id=$_REQUEST[id]");
	for($x=1;$x<= count($dates); $x++){
		$varname="d_date".$x;
		$tmp_date = explode("/", $_REQUEST[$varname]);
		$d_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
		$varname="close_warning_date$x";
		$tmp_date = explode("/", $_REQUEST[$varname]);
		$close_warning_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
		$varname="early_warning_date$x";
		$tmp_date = explode("/", $_REQUEST[$varname]);
		$early_warning_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
		$varname="expiry_date$x";
		if($_REQUEST[$varname]=="") $expiry_date=0;
		else {
			$tmp_date = explode("/", $_REQUEST[$varname]);
			$expiry_date = mktime(1,1,1,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
		}
		
		
		$varname="days_in_advance$x";
		if(!is_numeric($_REQUEST[$varname])) $days_in_advance=0; else $days_in_advance=$_REQUEST[$varname];
		$values=array(	'd_date'=>$d_date,
						'close_warning_date'=>$close_warning_date, 
						'early_warning_date'=>$early_warning_date, 
						'expiry_date'=>$expiry_date,
						'days_in_advance'=>$days_in_advance);
		$varname="date_id$x";
		$val=$_REQUEST[$varname];
		$result=mysqlUpdate("deadline_dates",$values,"date_id=$val");
		if($result != 1) $success.="Error updating: $result";
		
	} //next date entry
	if(isset($_REQUEST['override'])) $override=TRUE; else $override=FALSE;// flag for don't email deadline
    if(isset($_REQUEST['no_deadline'])) $no_deadline=TRUE; else $no_deadline=FALSE;
    
	$values = array(	'title'=>addslashes($_REQUEST['title']), 
						'warning_message'=>addslashes($_REQUEST['warning_message']), 
						'description'=>addslashes($_REQUEST['description']), 
						'synopsis'=>addslashes($_REQUEST['synopsis']), 
						'topics'=>addslashes($topics), 
						'approved'=>$approved, 
						'internal'=>$internal,
						'override'=>$override,
                        'no_deadline'=>$no_deadline); 
	if(mysqlUpdate("deadlines", $values, "deadline_id=$_REQUEST[id]")) $success.=" <strong>Deadline Updated</strong>";
	if($_REQUEST['action']=="add_date_update") {
		$values = array('null',$_REQUEST['id'],$d_date,$close_warning_date, $early_warning_date, $expiry_date,$days_in_advance);
		$result=mysqlInsert("deadline_dates", $values);
		if ($result != 1) $success.=" <strong>Error: $result</strong>"; else $success.=" <strong>Complete </strong>";
		$_REQUEST['section']='update';
	}
}
if (isset($_REQUEST['delete'])) {
    
	$result=mysqlDelete("deadline_dates","deadline_id=$_REQUEST[id]");
	$result2=mysqlDelete("deadlines", "deadline_id=$_REQUEST[id]");
	if($result !=1 || $result2 != 1) $success="<font color='#AA0000'>Error Deleting: $result $result2</font>"; 
	else $success=" <strong>Deadline Deleted</strong>";
}
if(isset($_REQUEST['action'])) if($_REQUEST['action']=="drop"){
	//echo $dropid;
	$result=mysqlDelete("deadline_dates","date_id=$_REQUEST[dropid]");
	if($result != 1) $success="<font color='#AA0000'>Error: $result</font>"; else $success="<strong>Dropped</strong>";
	$_REQUEST['section']="update";
}
if (isset($_REQUEST['section'])) {
	if(!isset($success)) $success="";
	switch($_REQUEST['section']){
		case "view":  
			$values = mysqlFetchRows("deadlines as d left join deadline_dates as dd on d.deadline_id=dd.deadline_id ","1 order by dd.d_date desc");
			$output = "";
			if(is_array($values)) {
				foreach($values as $index) {
					$dates=mysqlFetchRows("deadline_dates","deadline_id=$index[deadline_id]");
					
					if($index['d_date'] <= mktime()) $bgcolor="#D7D7D9"; else 
						if($index['internal']=="yes") $bgcolor="#CCCCFF";
						else $bgcolor="#CCFFCC";
					if(count($dates)>1) $multi="#FFCCCC";else $multi=$bgcolor;
                    if($index['no_deadline']) $bgcolor="#6666FF";
					$index['d_date'] = date("j/n/y", $index['d_date']);
					
					$mailitem_e=mysqlFetchRow("mail","assoc_id = $index[date_id] AND type='deadline-early'");
					$mailitem_c=mysqlFetchRow("mail","assoc_id = $index[date_id] AND type='deadline-close'");
					if(is_array($mailitem_e)) $ecol="<img src='/admin/images/check.gif'>"; else $ecol="";
					if(is_array($mailitem_c)) $ccol="<img src='/admin/images/check.gif'>"; else $ccol="";
					
					$output .= "
						<tr>
							<td bgcolor='#E09731'><a style='color:white' href='deadlines.php?section=update&id=$index[deadline_id]'>Update</a></td>
							<td bgcolor='$bgcolor'>$index[title]</td>
							<td bgcolor='$multi'>$index[d_date]</td>
							<td bgcolor='$bgcolor'>$index[synopsis]</td>
							<td bgcolor='$bgcolor'>$index[approved]</td>
							<td align='center' bgcolor='#D7D7D9'>$ecol</td>
							<td align='center' bgcolor='#D7D7D9'>$ccol</td>
						</tr>";
				}
				$hasharray = array('success'=>$success, 'output'=>$output);
				$filename = 'templates/template-deadlines_view.html';
			}
			else {
				$hasharray = array('title'=>"Deadlines");
				$filename = 'includes/error-no_records.html';
			}
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
            break;
		case "add":
			$topics = mysqlFetchRows("topics_research", "1 ORDER BY name");
			$topic_options = "";
			if(is_array($topics)) {
				foreach($topics as $topic) {
					$topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>";
					
				}
			}
			$hasharray = array('success'=>$success, 'topic_options'=>$topic_options);
			$filename = 'templates/template-deadlines_add.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
            break;
			
			
		case "update": 
			$picture_button = (mysqlFetchRow("pictures_associated", "object_id=$_REQUEST[id] AND table_name='deadlines'"))?
				"<br><br><button onClick=\"window.location='pictures-associate.php?section=update&id=$_REQUEST[id]&table_name=deadlines'\">View Associated Images</button>":"";
			//-- Selects the Record
			$values = mysqlFetchRow("deadlines", "deadline_id=$_REQUEST[id]");
			//-- Select the dates
			$dates = mysqlFetchRows("deadline_dates","deadline_id=$_REQUEST[id] order by d_date desc");
			
			//-- Selects the Topics
			$objects = explode(",", $values['topics']);
			$topics = mysqlFetchRows("topics_research", "1 ORDER BY name");
			$topic_options = ""; 
			if(is_array($objects) && $objects[0] != "") foreach($objects as $object) $ids[] = $object['topic_id'];			
			if(is_array($topics)) {
				foreach($topics as $topic) {
					if(in_array($topic['topic_id'], $objects)) $topic_options .= "<option value='$topic[topic_id]' selected>$topic[name]</option>";
					else $topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>"; 
				}
			}	
					
			if($values['approved'] == "yes")$approved = "checked";
			else $approved = "";
			if($values['internal'] == "yes")$internal = "checked";
			else $internal = "";
			if($values['override']) $override="checked"; else $override="";
            if($values['no_deadline']) $no_deadline="checked"; else $no_deadline=""; 
			//Process dates
			$x=1;$output="";
			foreach($dates as $date){
				$d_date = date("j/n/Y", $date['d_date']);
				$close_warning_date = date("j/n/Y", $date['close_warning_date']);
				$early_warning_date = date("j/n/Y", $date['early_warning_date']); 
				if($date['expiry_date']!=0) $expiry_date = date("j/n/Y", $date['expiry_date']); else $expiry_date=""; 
				
				$output.="
<input type='hidden' name='date_id$x' value='$date[date_id]'>
<tr><td colspan='5'><hr></td></tr>
<tr>
	<td>Deadline Date:</td>
	<td colspan='3'><input type='text' name='d_date$x' id='d_date$x' maxlength='10' size='10' value='$d_date'>
    <img src='/admin/includes/calendar.gif'  align='absmiddle' onclick='showChooser(this, \"d_date$x\", \"chooserSpan$x\", 2011, 2020, \"d/m/Y\", false);'>
        <div id='chooserSpan$x' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'></div>
    
	&nbsp;&nbsp;&nbsp;Due <input type='text' name='days_in_advance$x' value='$date[days_in_advance]' size='2'> days earlier in ORS";
				if($x>1) $output.="&nbsp;&nbsp;&nbsp;<button type='button' style='background-color: #FF3333;' onClick='document.form1.dropid.value=\"$date[date_id]\";document.form1.action.value=\"drop\"; document.form1.submit();'>Drop Date";
				$output.="</td>
</tr>
<tr>
	<td>Close Warning Date:</td>
	 <td colspan='3'><input type='text' name='close_warning_date$x' id='close_warning_date$x' maxlength='10' size='10' value='$close_warning_date'>
     <img src='/admin/includes/calendar.gif'  align='absmiddle' onclick=\"showChooser(this, 'close_warning_date$x', 'chooserSpanA$x', 2011, 2020, 'd/m/Y', false);\">
        <div id='chooserSpanA$x' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'></div>
	 &nbsp;&nbsp;&nbsp;Early Warning Date:<input type='text' name='early_warning_date$x' id='early_warning_date$x' maxlength='10' size='10' value='$early_warning_date'>
      <img src='/admin/includes/calendar.gif'  align='absmiddle' onclick=\"showChooser(this, 'early_warning_date$x', 'chooserSpanB$x', 2011, 2020, 'd/m/Y', false);\">
        <div id='chooserSpanB$x' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'></div>
	 &nbsp;&nbsp;&nbsp;Expiry Date:&nbsp;&nbsp;<input type='text' name='expiry_date$x' id='expiry_date$x' maxlength='10' size='10' value='$expiry_date'>
     <img src='/admin/includes/calendar.gif'  align='absmiddle' onclick=\"showChooser(this, 'expiry_date$x', 'chooserSpanC$x', 2011, 2020, 'd/m/Y', false);\">
        <div id='chooserSpanC$x' class='dateChooser select-free' style='display: none; visibility: hidden; width: 166px;'></div>
     <img src='/images/helpicon.gif' width='20' height='20'  border='0' align='absmiddle' onMouseOver=\"ShowHelp('d$x', 'Expiry Date', 'Leave blank to enable annual increments.')\" onMouseOut=\"HideHelp('d$x')\">
        <div style='display:none; font:Verdana, Arial, Helvetica, sans-serif; font-size:10px' id='d$x'></div>
	</tr>";
				$x++;
			}	
            $htmldescription=nl2br($values['description'])	;	
			$hasharray = array(	'id'=>$values['deadline_id'],
								'title'=>$values['title'], 
								'warning_message'=>$values['warning_message'], 
							   	'description'=>$values['description'],
                                'htmldescription'=>$htmldescription, 
								'synopsis'=>$values['synopsis'], 
								'topic_options'=>$topic_options, 
							   	'approved_a'=>$approved, 
								'picture_button'=>$picture_button, 
								'internal'=>$internal,'output'=>$output,
								'override'=>$override,
                                'no_deadline'=>$no_deadline,
								'success'=>$success);
			$filename = 'templates/template-deadlines_update.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
            break;
	} 
}
//-- Footer File
include("templates/template-footer.html");
?>