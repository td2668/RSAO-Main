<?php

include("includes/config.inc.php");
include_once("includes/functions-required.php");
include_once("includes/mail-functions.php");


define("NEWS", 0);
define("DEADLINE", 1);
define("SRD", 2);
define("OTHER", 3);

global $db;

$hdr=loadPage("header",'Header');

$menuitems=array();
$menuitems[]=array('title'=>'Add','url'=>'mailme.php?section=add');
$menuitems[]=array('title'=>'List','url'=>'mailme.php?section=view');
$hdr->AddRows("list",$menuitems);

$tmpl=loadPage("mailme", 'Mail');


set_time_limit(120);
$success="";
//error_reporting(E_ALL);
//Prep all variables after a submit
if ( isset($_REQUEST['update']) || isset($_REQUEST['usend']) || isset($_REQUEST['utestsend'])) {
    $topics_research = (isset($_REQUEST['topics_research']))?$topics_research = implode(",", $_REQUEST['topics_research']): "";
    $divisions = (isset($_REQUEST['divisions']))?$divisions = implode(",", $_REQUEST['divisions']): "";
    $userlist= (isset($_REQUEST['single_user']))?$userlist= implode(",",$_REQUEST['single_user']):"";
    if(($_REQUEST['s_date'] == "d/m/yy") || $_REQUEST['s_date']=="") $s_date=mktime();
    else {
        $tmp_date = explode("/", $_REQUEST['s_date']);
        $s_date = mktime(0,0,0,$tmp_date[0],$tmp_date[1],$tmp_date[2]);
    }

    if(isset($_REQUEST['ft_faculty'])) $ft_faculty=1;
    else $ft_faculty=0;
    if(isset($_REQUEST['pt_faculty'])) $pt_faculty=1;
    else $pt_faculty=0;
    if(isset($_REQUEST['management'])) $management=1;
    else $management=0;
    if(isset($_REQUEST['support'])) $support=1;
    else $support=0;
    if(isset($_REQUEST['outside'])) $outside=1;
    else $outside=0;
    if(isset($_REQUEST['chairs'])) $chairs=1;
    else $chairs=0;
    if(isset($_REQUEST['deans'])) $deans=1;
    else $deans=0;
    if(isset($_REQUEST['students'])) $students=1;
    else $students=0;
    if(isset($_REQUEST['abstract'])) $abstract=1;
    else $abstract=0;
    if($_REQUEST['from_email']=='') $_REQUEST['from_email']='research@viu.ca';
    if($_REQUEST['from_name']=='') $_REQUEST['from_name']='RSAO';
    //process file here
    $filename='';
    if(isset($_FILES['file'])) if($_FILES['file']['name'] != ""){
        if($_FILES["file"]["error"] > 0) {
            $success.="Error uploading file-Return Code: " . $_FILES["file"]["error"] ;
        }
        else {
            move_uploaded_file($_FILES["file"]["tmp_name"], $mail_file_path . $_FILES["file"]["name"]);
            $filename=$_FILES["file"]["name"];
            $success.="Uploaded file. ";
        }
    }
    if(isset($_REQUEST['override'])) {
        $override=true;
    }
    else {
        $override=false;
    };

    if(isset($_REQUEST['type'])) {
        $type = $_REQUEST['type'];
        if($type == 'news') {
            $type = NEWS;
        } elseif($type == 'deadline') {
            $type = DEADLINE;
        } else {
            $type = OTHER;
        }
    }
}

// Add new item or Add & Send
if (isset($_REQUEST['add']))  {
    
    $result = $db->Execute("INSERT INTO mail VALUES()");
    if(is_array($result)) $success.=" <strong>Complete</strong>";
    else echo ("Error Updating: $result");

    $_REQUEST['id']=$db->Insert_ID();
}

//Update existing or Update and Send
if (isset($_REQUEST['update']) || isset($_REQUEST['usend']) || isset($_REQUEST['utestsend'])){
    if(isset($_REQUEST['sent']) || isset($_REQUEST['usend'])) $sent=1; else $sent=0;

    if(!isset($filename)) $filename=$_REQUEST['old_filename'];


    $result=$db->Execute("UPDATE mail SET
    			 subject='".mysql_real_escape_string($_REQUEST['subject'])."',
                 body='".mysql_real_escape_string($_REQUEST['body'])."',
                 s_date='$s_date',
                 topics_research='$topics_research',
                 divisions='$divisions',
                 sent='$sent',
                 ft_faculty=$ft_faculty,
                 pt_faculty=$pt_faculty,
                 management=$management,
                 support=$support,
                 outside=$outside,
                 chairs=$chairs,
                 deans=$deans,
                 students=$students,
				 abstract='".mysql_real_escape_string($abstract)."',
                 single_user='$userlist',
                 filename='".mysql_real_escape_string($filename)."',
                 prepend='$_REQUEST[prepend]',
                 from_email='$_REQUEST[from_email]',
                 from_name='".mysql_real_escape_string($_REQUEST['from_name'])."',
                 mail_type='$type',
                 override='$override'
                 WHERE mail_id=$_REQUEST[id]");
    if($result) $success.=" <strong>Updated</strong>";
    else $success.= "Error Updating: ". $db->ErrorMsg() . ' ';
}

$plug_msg='@firstname@:<br><br>

';
$msg_subject='';
if(isset($_REQUEST['msg_flag'])) if($_REQUEST['msg_flag']=='1'){
    $msg=$db->GetRow("SELECT * FROM messages WHERE message_id=$special_msg");
    if(count($msg)>0){
        $plug_msg=$msg['message'];
        $msg_subject=$msg['name'];
    }
}

//------------------------Send Mail--------------------------

if (isset($_REQUEST['usend']) || isset($_REQUEST['utestsend'])) {

        $mailitems = array('subject'    => $_REQUEST['subject'],
                           'body'       => stripslashes($_REQUEST['body']),
                           'from_email' => $_REQUEST['from_email'],
                           'from_name'  => $_REQUEST['from_name']
        );

    $users = recipientBuilder(array(
                                   'ft_faculty'      => $ft_faculty,
                                   'pt_faculty'      => $pt_faculty,
                                   'management'      => $management,
                                   'support'         => $support,
                                   'outside'         => $outside,
                                   'chairs'          => $chairs,
                                   'deans'           => $deans,
                                   'tss'             => $tss,
                                   'srd'             => $srd,
                                   'strd'            => $strd,
                                   'abstract'        => $abstract,
                                   'topics_research' => $topics_research,
                                   'divisions'       => $divisions,
                                   'userlist'        => $userlist
                              ), $override, $type);


	//var_dump($users);

	$total = count($users);
	//var_dump('total', $total);
	//var_dump('users', $users);

	if (isset($_REQUEST['utestsend'])) {
	    $mailitems['testmail'] = true;
	    echo("<b>Admin Mailout only</b><br><br>");
	} else {
	    $mailitems['testmail'] = false;
	}
	if($_REQUEST['prepend']!='') {
	    $mailitems['subject']=$_REQUEST['prepend'] . ' ' . $mailitems['subject'];
	}

	if (isset($filename)) {
	    if ($filename != "") {
	        $mailitems["filename"] = $filename;
	    }
	}

	foreach ($users as $key => $user) {
	    //print_r($user['email'] . ' : ' . $user['first_name'] . " " . $user['last_name'] . "<br/>");
	    mailout($user, null, $mailitems);
	}

	//array_walk($users,'mailout',$mailitems);

	if ($total >= 1) {
	    $success .= " <strong>Mail sent to $total users</strong>";
	}
	else {
	    $success .= " <strong>Mail sent to no one at all</strong>";
	}

	//Add new mail_history item
	$groups = $people = $topics = '';
	if ($ft_faculty) {
	    $groups .= "Full-Time Faculty; ";
	}
	if ($pt_faculty) {
	    $groups .= "Part-Time Faculty; ";
	}
	if ($management) {
	    $groups .= "Management; ";
	}
	if ($support) {
	    $groups .= "Support Staff; ";
	}
	if ($outside) {
	    $groups .= "Outside; ";
	}
	if ($deans) {
	    $groups .= "Deans; ";
	}
	if ($chairs) {
	    $groups .= "Chairs; ";
	}
	if ($tss) {
	    $groups .= "TSS Faculty; ";
	}
	if ($srd) {
	    $groups .= "Student Research Day Participants;";
	}
	if ($strd) {
	    $groups .= "MM Student Research Day Participants;";
	}
	if ($abstract) {
	    $groups .= "(abstract missing only);";
	}

	if (isset($_REQUEST['single_user'])) {
	    foreach ($_REQUEST['single_user'] as $suser) {
	        $username = $db->GetRow("SELECT * FROM users WHERE user_id=$suser");
	        $people .= $username['last_name'] . ', ' . $username['first_name'] . '; ';
	    }
	}
	if (isset($_REQUEST['topics_research'])) {
	    foreach ($_REQUEST['topics_research'] as $topic) {
	        $tp = $db->GetRow("SELECT name FROM topics_research WHERE topic_id=$topic");
	        $topics .= $tp['name'] . '; ';
	    }
	}

	$result = mysqlInsert('mail_history', array(
	                                           'null',
	                                           $_REQUEST['id'],
	                                           $groups,
	                                           $people,
	                                           $topics,
	                                           $total,
	                                           mktime()
	                                      ));
	if ($result != 1) {
	    $success .= " Did not write history file: $result";
	}

	$filepath = "/var/www/html/";
	if ($logfile = fopen("{$configInfo['file_root']}admin/mail_log.txt", "a+")) {
	    $date = date("j/n/y", $todays_date);
	    fwrite($logfile, "-----------------\nDate: $date\n\n");
	    fwrite($logfile, "Immediate Mail: $mailitems[subject]\n");
	    if ($total >= 1) {
	        fwrite($logfile, "Mail sent to $total users\n\n");
	    }
	    else {
	        fwrite($logfile, "Mail sent to no one at all\n\n");
	    }
	    fclose($logfile);
	} else {
	    echo("Mail Log Is Not Writeable at " . $configInfo['file_root'] . "admin/mail_log.txt<br>");
	}
}
//if($notsent>=1) $success.=" (not sent to $notsent off-campus)";

//replace with the following after testing

//-----------------------------------------------------------

if (isset($_REQUEST['delete'])){
    if(mysqlDelete("mail", "mail_id=$_REQUEST[id]")) $success.=" <strong>Mail Deleted</strong>";
    mysqlDelete("mail_history","mail_id=$_REQUEST[id]");
}
$section = $_REQUEST['section'];
if (isset($_REQUEST['section'])) {
    if(!isset($success)) $success="";
    switch($_REQUEST['section']){
        case "view":
        	$tmpl->setAttribute("view","visibility","visible");
            //Show mail items using fields 'subject' and 'sent_date'
            $values = $db->GetAll("SELECT * FROM mail WHERE 1 order by s_date desc");
            $output = "";
            $out=array();
            if(count($values)>0) {
                foreach($values as $index) {
                    if($index['s_date'] == 0) $index['s_date']='Manual';
                        else $index['s_date'] = date("d/m/Y", $index['s_date']);
                    if($index['sent']==1) $index['sent']='#FF3333'; else $index['sent']='#D7D7D9';
                    $linkitem="";
                    if(($index['assoc_id'])!=0) {
                        if($index['type'] == "opportunity") {
                            $item=$db->GetRow("SELECT * FROM opportunities WHERE opportunity_id=$index[assoc_id]");
                            if(count($item)>0) $linkitem="Opp: ".$item['title'];
                        }
                        else if ($index['type'] == "deadline-early") {
                            $item=$db->GetRow("SELECT * FROM deadlines as d left join deadline_dates as dd on d.deadline_id=dd.deadline_id WHERE date_id=$index[assoc_id]");
                            if(count($item)>0) $linkitem="DL-Early: ".$item['title']." (".date("j/n/y", $item['d_date']).")";
                        }
                        else if ($index['type'] == "deadline-close") {
                            $item=$db->GetRow("SELECT * FROM deadlines as d left join deadline_dates as dd on d.deadline_id=dd.deadline_id WHERE date_id=$index[assoc_id]");
                            if(count($item)>0) $linkitem="DL-Late: ".$item['title']." (".date("j/n/y", $item['d_date']).")";
                        }
                    }
                    //if($index['send_all']) $index['subject'] .= " (SEND ALL)";
                    //if($index['send_admin']) $index['subject'] .= " (ADMIN ONLY)";
                    
                    $index['linkitem']=$linkitem;
                    $index['rowtype']='main';
                    $out[]=$index;
                    
                    
                    /*
$output .= "
                        <tr>
                            <td bgcolor='#E09731'><a style='color:white' href='mailme.php?section=update&id=$index[mail_id]'>Update</a></td>
                            <td width='25' bgcolor='#E09731'><a style='color:white' href='mailme.php?delete&id=$index[mail_id]&section=view'>Delete</a></td>
                            <td bgcolor='#D7D7D9'>$index[subject]</td>
                            <td bgcolor='#D7D7D9'>$index[s_date]</td>
                            <td bgcolor='$index[sent]'>&nbsp;</td>
                            <td bgcolor='#D7D7D9'>$linkitem</td>
                            </tr>";
*/


                    $mailitems=$db->GetAll("SELECT * FROM mail_history WHERE mail_id=$index[mail_id]");

                    if(count($mailitems)>0) {
                        foreach($mailitems as $mailitem){
                            if($mailitem['date'] == 0) $index['date1']='Manual';
                            else $index['date1'] = date($iso8601, $mailitem['date']);
                            
                            if($mailitem['groups']<>"") {$index['type']='Groups:'; $index['item']=$mailitem['groups'];}
                            elseif($mailitem['people']<>"") {$index['type']='People:'; $index['item']=$mailitem['people'];}
                            elseif($mailitem['topics']<>"") {$index['type']='Topics:'; $index['item']=$mailitem['topics'];}
                            else {$index['type']=''; $index['item']='';}
                            $index['count']=$mailitem['count'];
                            $index['rowtype']='sub';
                            $out[]=$index;
                        }
                    }
                }
                $tmpl->AddRows("viewlist",$out);
                //$hasharray = array('success'=>$success, 'output'=>$output);
                //$filename = 'templates/template-mail_view.html';
            }
            else {
                //$hasharray = array('title'=>"Mail");
                //$filename = 'includes/error-no_records.html';
            }
            //$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
            //echo $parsed_html_file;
        break;

        

        case "update":
            $values = mysqlFetchRow("mail", "mail_id=$_REQUEST[id]");
            //-- Selects the Topics
            $objects = explode(",", $values['topics_research']);
            $topics = mysqlFetchRows("topics_research", "1 ORDER BY name");
            $topic_options = "<option value='0'></option>";
            if(is_array($topics)) {
                foreach($topics as $topic) {
                    //$sub_topics = mysqlFetchRows("topics_research", "parent_id=$topic[topic_id] order by name");
                    if(in_array($topic['topic_id'], $objects)) $topic_options .= "<option value='$topic[topic_id]' selected>$topic[name]</option>";
                    else $topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>";
                }//foreach topic
            }//if isarray topics


            $objects = explode(",", $values['divisions']);
            $divisions = mysqlFetchRows("divisions", "1 ORDER BY name");
            $division_options = "";

            if(is_array($objects) && $objects[0] != "") foreach($objects as $object) $ids[] = $object['topic_id'];
            if(is_array($divisions)) {
                foreach($divisions as $division) {
                    if(in_array($division['division_id'], $objects)) $division_options .= "<option value='$division[division_id]' selected>$division[name]</option>";
                    else $division_options .= "<option value='$division[division_id]'>$division[name]</option>";

                }
            }

            $objects = explode(",", $values['single_user']);
            $users=mysqlFetchRows("users","1 order by last_name,first_name");
            $single_user_list="<option value=''></option>";
            if(is_array($users)) {
                foreach($users as $user) {
                    if(in_array($user['user_id'], $objects)) $sel='selected'; else $sel='';
                    if((strlen($user['last_name']) > 1) && (strlen($user['first_name']) > 1)) {
                     $single_user_list .= "<option value='$user[user_id]' $sel>$user[last_name], $user[first_name]</option>\n";
                    }
                }
            }
            if($values['s_date'] != "") $s_date = date("m/d/Y", $values['s_date']);
            if($values['ft_faculty'] ==1) $ft_faculty='checked';
            else $ft_faculty="";
            if($values['pt_faculty'] ==1) $pt_faculty='checked';
            else $pt_faculty="";
            if($values['management'] ==1) $management='checked';
            else $management="";
            if($values['support'] ==1) $support='checked';
            else $support="";
            if($values['outside'] ==1) $outside='checked';
            else $outside="";
            if($values['chairs'] ==1) $chairs='checked';
            else $chairs="";
            if($values['deans'] ==1) $deans='checked';
            else $deans="";
            if($values['students'] ==1) $students='checked';
            else $students="";
            if($values['tss'] ==1) $tss='checked';
            else $tss="";
            if($values['srd'] ==1) $srd='checked';
            else $srd="";
            if($values['strd'] ==1) $strd='checked';
            else $strd="";
            if($values['abstract'] ==1) $abstract='checked';
            else $abstract="";
            if($values['sent'] == 1) $sent="checked"; else $sent="";
            if($values['override'] == 1) $override="checked"; else $override="";

            $type_news = '';
            $type_deadline = '';
            $type_other = '';

            if($values['mail_type'] == NEWS) {
                $type_news = 'checked';
            }
            if($values['mail_type'] == DEADLINE) {
                $type_deadline='checked';
            }
            if($values['mail_type'] == OTHER) {
                $type_other = 'checked';
            }
            $hasharray = array('success'          => $success,
                               'topic_options'    => $topic_options,
                               'division_options' => $division_options,
                               'subject'          => $values['subject'],
                               's_date'           => $s_date,
                               'body'             => stripslashes($values['body']),
                               'id'               => $values['mail_id'],
                               'sent'             => $sent,
                               'ft_faculty'       => $ft_faculty,
                               'pt_faculty'       => $pt_faculty,
                               'management'       => $management,
                               'support'          => $support,
                               'outside'          => $outside,
                               'chairs'           => $chairs,
                               'deans'            => $deans,
                               'single_user_list' => $single_user_list,
                               'filename'         => $values['filename'],
                               'students'         => $students,
                               'tss'              => $tss,
                               'srd'              => $srd,
                               'strd'             => $strd,
                               'abstract'         => $abstract,
                               'prepend'          => $values['prepend'],
                               'from_email'       => $values['from_email'],
                               'from_name'        => $values['from_name'],
                               'override'         => $override,
                               'type_news'        => $type_news,
                               'type_deadline'    => $type_deadline,
                               'type_other'       => $type_other
            );
            $filename = 'templates/template-mail_update.html';
            $parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
            echo $parsed_html_file;

        break;

        case "lists":
            $output="";
             $topics = mysqlFetchRows("topics_research ","1 order by name");
             $divisions=mysqlFetchRows("divisions",'1 order by name');
             foreach($topics as $topic) {
                 $output.= "<tr><td><b>$topic[name]</b></td></tr>";
                 $total=0;
                 foreach($divisions as $division){

                     $sql=" SELECT * FROM users as u
                            LEFT JOIN departments as d on (u.department_id=d.department_id)
                            LEFT JOIN divisions as di on (d.division_id=di.division_id)
                            LEFT JOIN user_topics_filter as utf on (u.user_id=utf.user_id)
                            LEFT JOIN users_disabled as ud on (u.user_id=ud.user_id)
                            WHERE
                            utf.topic_id=$topic[topic_id] AND
                            u.mail_deadlines=1 AND
                            di.division_id=$division[division_id] AND
                            ISNULL(ud.user_id); ";
                     $result=mysql_num_rows(mysql_query($sql));
                     $total+=$result;
                     $output.="<tr><td>$division[name]</td><td>$result</td></tr>\n";
                 }
                 $output.="<tr><td>TOTAL:</td><td>$total</td></tr><tr><td colspan=2><hr></td></tr>\n";


             }

            $hasharray = array('success'=>$success, 'output'=>$output);
            $filename = 'templates/template-mail_lists.html';

            $parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
            echo $parsed_html_file;

        break;
    } //switch
}
$hdr->AddVar('header','success',$success);
$hdr->displayParsedTemplate('header');
$tmpl->displayParsedTemplate('page');

