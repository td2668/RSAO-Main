<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");

$hdr=loadPage("header",'Header');

$menuitems=array();
$menuitems[]=array('title'=>'Add','url'=>'deadlines.php?section=add');
$menuitems[]=array('title'=>'List','url'=>'deadlines.php?section=view');
$hdr->AddRows("list",$menuitems);


$tmpl=loadPage("deadlines", 'Deadlines');

$success="";
/*
echo"<pre>";
print_r($_POST);
print_r($_GET); 
echo"</pre>";
*/
if(isset($_REQUEST['action'])) if(isset($_REQUEST['add']) || isset($_REQUEST['update']) || $_REQUEST['action']=="add_date_add" || $_REQUEST['action']=="add_date_update") {
	
	$topics = (isset($_REQUEST['topics']))?$topics = implode(",", $_REQUEST['topics']): "";
	if(!isset($_REQUEST['approved'])) $approved = "no"; else $approved='yes';
	if(!isset($_REQUEST['internal'])) $internal = "no"; else $internal='yes';
}

if(isset($_REQUEST['action'])) if(isset($_REQUEST['add']) || $_REQUEST['action']=="add_date_add") {
	//only one date for an ADD
	//echo ("Here");
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
    
    $sql="INSERT INTO deadlines SET
    	deadline_id='null',
    	title='". mysql_escape_string($_REQUEST['title']) ."',
    	warning_message='". mysql_escape_string($_REQUEST['warning_message']) ."',
    	description='". mysql_escape_string($_REQUEST['description']) ."',
    	synopsis='" . mysql_escape_string($_REQUEST['synopsis']) ."',
    	topics= '$topics',
    	approved='$approved',
    	internal='$internal',
    	override=$override,
    	no_deadline=$no_deadline
    	";

    if(!$db->Execute($sql)) $success.='Error inserting into deadlines table';
		else{
			$success = " <strong>Deadline Inserted;</strong>";
			$id=$db->Insert_ID();
			}
	
	$sql="INSERT INTO deadline_dates SET
		date_id='null',
		deadline_id=$id,
		d_date=$d_date,
		close_warning_date=$close_warning_date,
		early_warning_date=$early_warning_date,
		expiry_date=$expiry_date,
		days_in_advance=$days_in_advance
	";
	if(!$db->Execute($sql)) $success.='Error inserting deadline date into table';
		else{
			$success .= " <strong>Complete (1 date); </strong>";
			$id=$db->Insert_ID();
			}
	
	//add a date entry by repeating the entry (can't use zero or dates get weird)
	if($action=="add_date_add"){
		if(!$db->Execute($sql)) $success.='Error inserting new deadline date into table';
		else{
			$success .= " <strong>New entry added; </strong>";
			$id=$db->Insert_ID();
			}

		$section='update';
	}
}
else if(isset($_REQUEST['action'])) if (isset($_REQUEST['update']) || $_REQUEST['action']=="add_date_update") {
	
	$sql="SELECT * FROM deadline_dates WHERE deadline_id=$_REQUEST[id]";
	$dates=$db->GetAll($sql);

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
		
		$varname="date_id$x";
		$val=$_REQUEST[$varname];
		$sql="UPDATE deadline_dates SET
			deadline_id=$id,
			d_date=$d_date,
			close_warning_date=$close_warning_date,
			early_warning_date=$early_warning_date,
			expiry_date=$expiry_date,
			days_in_advance=$days_in_advance
			WHERE date_id=". $_REQUEST[$varname].";";
		if(!$db->Execute($sql)) $success.=" Error updating date $x ;";
		else $success .= " <strong>Date updated; </strong>";
		
		
	} //next date entry
	if(isset($_REQUEST['override'])) $override=TRUE; else $override=FALSE;// flag for don't email deadline
    if(isset($_REQUEST['no_deadline'])) $no_deadline=TRUE; else $no_deadline=FALSE;
    
    $sql="UPDATE deadlines SET
		title='".addslashes($_REQUEST['title'])."', 
		warning_message='".addslashes($_REQUEST['warning_message'])."', 
		description='".addslashes($_REQUEST['description'])."', 
		synopsis='".addslashes($_REQUEST['synopsis'])."', 
		topics='".addslashes($topics)."', 
		approved=$approved, 
		internal=$internal,
		override=$override,
        no_deadline=$no_deadline
        WHERE deadline_id=".$_REQUEST['id'].";"; 
    if(!$db->Execute($sql)) $success.=" Error updating deadline ;";
	else $success .= " <strong>Deadline updated; </strong>";


	if($_REQUEST['action']=="add_date_update") {
		$sql="INSERT INTO deadline_dates SET
			date_id='null',
			deadline_id=$_REQUEST[id],
			d_date=$d_date,
			close_warning_date=$close_warning_date,
			early_warning_date=$early_warning_date,
			expiry_date=$expiry_date,
			days_in_advance=$days_in_advance
			";
		if(!$db->Execute($sql)) $success.=" Error adding date $x ;";
		else $success .= " <strong>Date added; </strong>";
		
		$_REQUEST['section']='update';
	}
}
if (isset($_REQUEST['delete'])) {
    $sql="DELETE FROM deadline_dates WHERE deadline_id=$_REQUEST[id]";
    if(!$db->Execute($sql)) $success.=" Error deleting date ;";
    $sql="DELETE FROM deadlines WHERE deadline_id=$_REQUEST[id]";
    if(!$db->Execute($sql)) $success.=" Error deleting deadline ;";
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
			$tmpl->setAttribute("view","visibility","visible");
			$sql="SELECT * FROM deadlines as d 
				LEFT JOIN deadline_dates as dd on d.deadline_id=dd.deadline_id
				ORDER BY dd.d_date DESC";
			$values=$db->GetAll($sql);
			$viewlist=array();
			if(is_array($values)) {
				foreach($values as $index) {
					$sql="SELECT * FROM deadline_dates WHERE deadline_id=$index[deadline_id]";
					$dates=$db->GetAll($sql);
					
					if($index['d_date'] <= mktime()) $index['bgcolor']="#D7D7D9"; else 
						if($index['internal']=="yes") $index['bgcolor']="#CCCCFF";
						else $index['bgcolor']="#CCFFCC";
					if(count($dates)>1) $index['multi']="#FFCCCC";else $index['multi']=$bgcolor;
                    if($index['no_deadline']) $index['bgcolor']="#6666FF";
					$index['d_date'] = date("j/n/y", $index['d_date']);
					$sql="SELECT * FROM mail WHERE assoc_id=$index[date_id] AND type='deadline-early'";
					$mailitem_e=$db->GetRow($sql);
					$sql="SELECT * FROM mail WHERE assoc_id=$index[date_id] AND type='deadline-close'";
					$mailitem_c=$db->GetRow($sql);

					if(is_array($mailitem_e)) $index['ecol']="<img src='/admin/images/check.gif'>"; else $index['ecol']="";
					if(is_array($mailitem_c)) $index['ccol']="<img src='/admin/images/check.gif'>"; else $index['ccol']="";
					
					$viewlist[]=$index;
				}
				
			}
			//print_r($viewlist[0]); 
			$tmpl->AddRows('viewlist',$viewlist);
            break;
		case "add":
			$sql="SELECT name,topic_id FROM topics_research WHERE 1 ORDER BY name";
			$topics=$db->Execute($sql);
			
			$topic_options=$topics->GetMenu('topics[]','',true,true,8);
			$tmpl->AddVars('add',array( 'topic_options'=>$topic_options,
                                        'success'=>$success));
			$tmpl->setAttribute("add","visibility","visible");
			$hdr->AddVar("header","title","Deadlines: Add New");
			
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


$hdr->AddVar('success','success',$success);
$hdr->displayParsedTemplate('header');
$tmpl->displayParsedTemplate('page');

?>