<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/mail-functions.php");
include("includes/class-template.php");
//include("includes/garbage_collector.php");
$template = new Template;
//require("security.php"); 
//-- Header File
include("templates/template-header.html");
$success="";
if (isset($add) || isset($update) || isset($asend) || isset($usend) || isset($atestsend) || isset($utestsend)) {
	$topics_research = (isset($topics_research))?$topics_research = implode(",", $topics_research): "";

	$departments = (isset($departments))?$departments = implode(",", $departments): "";
	if(($s_date == "d/m/yy")) $s_date="1/1/2036";
	if($s_date != "") {
		$tmp_date = explode("/", $s_date);
		$s_date = mktime(0,0,0,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	}
	if(isset($health)) $health=1;
	else $health=0;
	if(isset($sshrc)) $sshrc=1;
	else $sshrc=0;
	if(isset($nserc)) $nserc=1;
	else $nserc=0;
	if(isset($indust)) $indust=1;
	else $indust=0;
	if(isset($all_researchers)) $all_researchers=1;
	else $all_researchers=0;
	if(isset($regular_faculty)) $regular_faculty=1;
	else $regular_faculty=0;
	if(isset($outside)) $outside=1;
	else $outside=0;
	if(isset($chairs)) $chairs=1;
	else $chairs=0;
	if(isset($deans)) $deans=1;
	else $deans=0;

}
// Add new item or Add & Send
if (isset($add) || isset($asend) || isset($atestsend)) {
	if (isset($asend)) $sent=1; else $sent=0;
	$values = array('null', $subject, $body, $s_date, $topics_research, $departments, $health, $nserc, $sshrc, $indust, $sent, 'null', 'null',$all_researchers,$regular_faculty,$outside,$chairs,$deans,$single_user);
	$result = mysqlInsert("mail", $values);
	if($result==1) $success=" <strong>Complete</strong>";
	else echo ("Error Updating: $result");
}

//Update existing or Update and Send
if (isset($update) || isset($usend) || isset($utestsend)){
	if(isset($sent) || isset($usend)) $sent=1; else $sent=0;
	$values = array('subject'=>$subject, 'body'=>$body, 's_date'=>$s_date, 'topics_research'=>$topics_research, 'departments'=>$departments, 'health'=>$health, 'nserc'=>$nserc, 'sshrc'=>$sshrc, 'indust'=>$indust, 'sent'=>$sent,'all_researchers'=>$all_researchers,'regular_faculty'=>$regular_faculty,'outside'=>$outside,'chairs'=>$chairs,'deans'=>$deans,'single_user'=>$single_user);
	$result = mysqlUpdate("mail", $values, "mail_id=$id");
	if($result == 1) $success=" <strong>Updated</strong>";
	else echo ("Error Updating: $result");
}

$plug_msg='@firstname@:<br><br>

';
$msg_subject='';
if(isset($msg_flag)) if($msg_flag=='1'){
	$msg=mysqlFetchRow("messages","message_id=$special_msg");
	if(is_array($msg)){
		$plug_msg=$msg['message'];
		$msg_subject=$msg['name'];		
	}
}
//------------------------Send Mail--------------------------
if (isset($usend) || isset($asend) || isset($atestsend) || isset($utestsend)) {
	$mailitems = array('subject'=>$subject, 'body'=>$body);
	//grab all users and put ids into an array ready to tick off items
	$users=mysqlFetchRows("users");
	if(is_array($users)) {
		array_walk($users,'reset_user');
		
		if($single_user !=0){
			foreach($users as $key=>$user) if($user['user_id']==$single_user) $users[$key]['visits']=1;
		}
		else if (!($all_researchers || $regular_faculty || $chairs || $deans || $outside)){
			
			//if general subject areas are checked, add these to the list of research topics
			//used a variable variable in here: $$group lets me check $health, $nserc etc in a loop
			if($health || $nserc || $sshrc || $indust){
				$groups = array("health","nserc","sshrc","indust");
				foreach($groups as $group){
					$topic_list = mysqlFetchRows("topics_research");
					if (is_array($topic_list))
					foreach($topic_list as $topic)
					if ($$group && $topic[$group]== 1 && !in_array($topic['topic_id'], explode(",",$topics_research)))  $topics_research .= ",$topic[topic_id]";
				}//foreach group
			}//if health
	//		echo("Topics_Research = $topics_research<br>");
			array_walk($users,'check_topics',$topics_research);
			//$total=0;
			//foreach($users as $user) if ($user['visits']==1) $total++;
			//if($total >= 1) $success=" <strong>Mail prepared for $total users (before overrides)</strong><br>";
			if (isset($utestsend) || isset($atestsend)) {$mailitems['testmail']=true; echo("<b>Admin Mailout only</b><br><br>");}
			else $mailitems['testmail']=false;
			
			//Remove them if they don't want deadlines or opportunities
			foreach($users as $key=>$user) if ($user['mail_deadlines']!=1 && $user['mail_opps']!=1) $users[$key]['visits']=0;
		
		} // if no overrides set
		else {  // An override was set, so only send to the items selected 
		
			foreach($users as $key=>$user){
				if($all_researchers && $user['researcher_id'] != 0)
					$users[$key]['visits']=1;
				if($regular_faculty && $user['researcher_id']==0 && (strpos($user['email'],'tru.ca') || strpos($user['email'],'cariboo.bc.ca'))) 
					$users[$key]['visits']=1;
				if($outside && !(strpos($user['email'],'tru.ca') || strpos($user['email'],'cariboo.bc.ca'))) 
					$users[$key]['visits']=1;
				if($deans && mysql_num_rows(mysql_query("select * from divisions where dean=$user[user_id]")) >= 1) 
					$users[$key]['visits']=1;
				if($chairs && mysql_num_rows(mysql_query("select * from departments where chair=$user[user_id]")) >= 1) 
					$users[$key]['visits']=1;
			}//foreach user
			
		} // Override section
		if (isset($utestsend) || isset($atestsend)) {$mailitems['testmail']=true; echo("<b>Admin Mailout only</b><br><br>");}
		else $mailitems['testmail']=false;
			
		array_walk($users,'mailout',$mailitems);
		//echo("Sent to: <br>");
		$total = 0;
		//array_walk($users,'list_users',$total);
		foreach($users as $user) if ($user['visits']==1) $total++;
		if($total >= 1) $success.=" <strong>Mail sent to $total users</strong>";
		else $success.=" <strong>Mail sent to no one at all</strong>";
		
		$filepath = "/home/html_root/htdocs/";
		if (!$logfile = fopen("{$filepath}admin/mail_log.txt","a+")) die("Mail Log Is Not Writeable");
		$date=date("j/n/y",$todays_date);
		fwrite($logfile,"-----------------\nDate: $date\n\n");
		fwrite($logfile,"Immediate Mail: $mailitems[subject]\n");
		if($total >= 1) fwrite($logfile,"Mail sent to $total users\n\n");
		else fwrite($logfile,"Mail sent to no one at all\n\n");
		fclose($logfile);
		//if($notsent>=1) $success.=" (not sent to $notsent off-campus)";
		
			//replace with the following after testing
	}//if isarray $users
}

//-----------------------------------------------------------
if (isset($delete)){
	if(mysqlDelete("mail", "mail_id=$id")) $success=" <strong>Mail Deleted</strong>";
}

if (isset($section)) {
	if(!isset($success)) $success="";
	switch($section){
		case "view":
			//Show mail items using fields 'subject' and 'sent_date'
			$values = mysqlFetchRows("mail","1 order by s_date desc");
			$output = "";
			if(is_array($values)) {
				foreach($values as $index) {
				$index['s_date'] = date("j/n/y", $index['s_date']);
				if($index['sent']==1) $index['sent']='#FF3333'; else $index['sent']='#D7D7D9';
				$linkitem="";
				if(!is_null($index['assoc_id'])) {
					if($index['type'] == "opportunity") {
						$item=mysqlFetchRow("opportunities","opportunity_id=$index[assoc_id]");
						if(is_array($item)) $linkitem="Opp: ".$item['title']; 
					}
					else if ($index['type'] == "deadline-early") {
						$item=mysqlFetchRow("deadlines as d left join deadline_dates as dd on d.deadline_id=dd.deadline_id","date_id=$index[assoc_id]");
						if(is_array($item)) $linkitem="DL-Early: ".$item['title']." (".date("j/n/y", $item['d_date']).")";
					}
					else if ($index['type'] == "deadline-close") {
						$item=mysqlFetchRow("deadlines as d left join deadline_dates as dd on d.deadline_id=dd.deadline_id","date_id=$index[assoc_id]");
						if(is_array($item)) $linkitem="DL-Late: ".$item['title']." (".date("j/n/y", $item['d_date']).")";
					}
				} 
				//if($index['send_all']) $index['subject'] .= " (SEND ALL)";
				//if($index['send_admin']) $index['subject'] .= " (ADMIN ONLY)";
				$output .= "
					<tr>
						<td bgcolor='#E09731'><a style='color:white' href='mail.php?section=update&id=$index[mail_id]'>Update</a></td>
						<td bgcolor='#D7D7D9'>$index[subject]</td>
						<td bgcolor='#D7D7D9'>$index[s_date]</td>
						<td bgcolor='$index[sent]'>&nbsp;</td>
						<td bgcolor='#D7D7D9'>$linkitem</td>
						</tr>";
				}
				$hasharray = array('success'=>$success, 'output'=>$output);
				$filename = 'templates/template-mail_view.html';
			}
			else {
				$hasharray = array('title'=>"Mail");
				$filename = 'includes/error-no_records.html';
			}
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
		break;
		
		case "add":
			//Grab subjects list
			$topics = mysqlFetchRows("topics_research", "level=1 ORDER BY name");
			$topic_options = "";
			if(is_array($topics)) {
				foreach($topics as $topic) {
					$sub_topics = mysqlFetchRows("topics_research", "parent_id=$topic[topic_id] order by name"); 
					$topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>";
					if(is_array($sub_topics)) {
						foreach($sub_topics as $sub_topic) {
							$topic_options .= "<option value='$sub_topic[topic_id]'>&nbsp;&nbsp;&nbsp;&nbsp;$sub_topic[name]</option>";
						}
					} 
				}
			}
			
			//Grab departments list
			$values = mysqlFetchRows("departments", "1 ORDER BY name");
			$department_options = "";
			if(is_array($values)) foreach($values as $index) $department_options .= "<option value='$index[department_id]'>$index[name]</option>"; 
			
			//Grab Users List
			$users=mysqlFetchRows("users","1 order by last_name,first_name");
			$single_user_list="";
			if(is_array($users)) foreach($users as $user) $single_user_list .= "<option value='$user[user_id]'>$user[last_name], $user[first_name]</option>\n";
			
			//Grab Special Messages List
			$msgs=mysqlFetchRows("messages","1 order by name");
			$special_msg_options="";
			if(is_array($msgs)) foreach($msgs as $msg) $special_msg_options.="<option value='$msg[message_id]'>$msg[name]</option>\n";
			
			$hasharray = array('msg_subject'=>$msg_subject,'plug_msg'=>htmlentities($plug_msg),'success'=>$success, 'topic_options'=>$topic_options, 'department_options'=>$department_options,'single_user_list'=>$single_user_list,'special_msg_options'=>$special_msg_options);
			$filename = 'templates/template-mail_add.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
			
		
		break;
		
		case "update":
			$values = mysqlFetchRow("mail", "mail_id=$id");
			//-- Selects the Topics
			$objects = explode(",", $values['topics_research']);
			$topics = mysqlFetchRows("topics_research", "level=1 ORDER BY name");
			$topic_options = "";
//			if(is_array($objects) && $objects[0] != "") foreach($objects as $object) {$ids[] = $object['topic_id'];echo("$object[topic_id]<br>");}			
			if(is_array($topics)) {
				foreach($topics as $topic) {
					$sub_topics = mysqlFetchRows("topics_research", "parent_id=$topic[topic_id] order by name"); 
					if(in_array($topic['topic_id'], $objects)) $topic_options .= "<option value='$topic[topic_id]' selected>$topic[name]</option>";
					else $topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>";
					 
					if(is_array($sub_topics)) {
						foreach($sub_topics as $sub_topic) {
							if(in_array($sub_topic['topic_id'], $objects)) $topic_options .= "<option selected value='$sub_topic[topic_id]'>&nbsp;&nbsp;&nbsp;&nbsp;$sub_topic[name]</option>"; 
							else $topic_options .= "<option value='$sub_topic[topic_id]'>&nbsp;&nbsp;&nbsp;&nbsp;$sub_topic[name]</option>";
						}//foreach
					} //if isarray
				}//foreach topic
			}//if isarray topics
			
			
			$objects = explode(",", $values['departments']);
			$departments = mysqlFetchRows("departments", "1 ORDER BY name");
			$department_options = "";
			
			if(is_array($objects) && $objects[0] != "") foreach($objects as $object) $ids[] = $object['topic_id'];			
			if(is_array($departments)) {
				foreach($departments as $department) {
					if(in_array($department['department_id'], $objects)) $department_options .= "<option value='$department[department_id]' selected>$department[name]</option>";
					else $department_options .= "<option value='$department[department_id]'>$department[name]</option>";
					 
				}//foreach topic
			}//if isarray topics
			$users=mysqlFetchRows("users","1 order by last_name,first_name");

			$single_user_list="<option value='0'></option>";
			if(is_array($users)) foreach($users as $user) {
				if($user['user_id']==$values['single_user']) $sel="selected"; else $sel="";
				$single_user_list .= "<option value='$user[user_id]' $sel>$user[last_name], $user[first_name]</option>\n";
			}
			
			
			if($values['s_date'] != "") $s_date = date("j/n/y", $values['s_date']);	
			if($values['health'] ==1 ) $health='checked';
			else $health="";
			if($values['sshrc'] ==1) $sshrc='checked';
			else $sshrc="";
			if($values['nserc'] ==1) $nserc='checked';
			else $nserc="";
			if($values['indust'] ==1) $indust='checked';
			else $indust="";
			if($values['all_researchers'] ==1) $all_researchers='checked';
			else $all_researchers="";
			if($values['regular_faculty'] ==1) $regular_faculty='checked';
			else $regular_faculty="";
			if($values['outside'] ==1) $outside='checked';
			else $outside="";
			if($values['chairs'] ==1) $chairs='checked';
			else $chairs="";
			if($values['deans'] ==1) $deans='checked';
			else $deans="";
			if($values['sent'] == 1) $sent="checked"; else $sent="";
			$hasharray = array('success'=>$success, 'topic_options'=>$topic_options, 'department_options'=>$department_options, 'subject'=>$values['subject'], 's_date'=>$s_date, 'body'=>$values['body'],'id'=>$values['mail_id'], 'health'=>$health, 'nserc'=>$nserc, 'sshrc'=>$sshrc, 'indust'=>$indust, 'sent'=>$sent,'all_researchers'=>$all_researchers,'regular_faculty'=>$regular_faculty,'outside'=>$outside,'chairs'=>$chairs,'deans'=>$deans,'single_user_list'=>$single_user_list);
			$filename = 'templates/template-mail_update.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
			
		break;
	} //switch	
}
include("templates/template-footer.html");
?>