<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");
$picture_path="/var/www/research_htdocs/pictures";
//include("includes/garbage_collector.php");
$template = new Template;
//require("security.php");

include("html/header.html");

if(isset($_REQUEST['project_id']) && isset($_REQUEST['country_code']) && isset($_REQUEST['state_code']))
if(($_REQUEST['project_id']) > 0 && ($_REQUEST['country_code']) != '0' && ($_REQUEST['state_code']) != '0'){
    if($_REQUEST['country_code']=='CA') $_REQUEST['country_code']=$_REQUEST['state_code'];
    $sql="UPDATE projects SET country_code='{$_REQUEST['country_code']}', state_code='{$_REQUEST['state_code']}' WHERE project_id={$_REQUEST['project_id']}";
    $result = $db->Execute($sql);
    if($result) $success=" <strong>Complete</strong>";
    else $success=" Error: $result";
    
}

/*
if(isset($_REQUEST['delete_loc'])){
    if (mysqlDelete('projects_where',"project_where_id=$_REQUEST[loc_id]")) $success='Deleted';
    else $success='Error deleting';
    $_REQUEST['section']='where';
}
*/
if(isset($_POST['add'])) {
	if (isset($_POST['feature'])) $featureflag = 1;
	else $featureflag = 0;
	if (isset($_POST['studentflag'])) $studentflag = 1;
	else $studentflag = 0;
    if (isset($_POST['approved'])) $approved = 1;
    else $approved = 0;
    if (isset($_POST['internal_grant'])) $internal_grant = 1;
    else $internal_grant = 0;
    
	$tmp_date = explode("/", $_POST['enddate']);
	$enddate = mktime(0,0,0,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
	//$approved=1;
    $mod=date('Y-m-d');
    $_POST['name']=mysql_real_escape_string($_POST['name']);
    $_POST['synopsis']=mysql_real_escape_string($_POST['synopsis']);
    $_POST['description']=mysql_real_escape_string($_POST['description']);
    $_POST['keywords']=mysql_real_escape_string($_POST['keywords']);
    $_POST['students']=mysql_real_escape_string($_POST['students']);       
    //Figure out the next ObjectID for auto increment
    //$sql="SELECT MAX(ObjectID)as max from projects where 1";
    //$max=$db->GetRow($sql);
    //$objectid=$max['max']+1;
    $sql = "INSERT INTO projects(name, synopsis, description, feature, keywords, studentproj, student_names, end_date,
                                         approved, doll_per_yr, status, modified, who_modified,boyerDiscovery,boyerIntegration,boyerApplication,boyerTeaching,boyerService,internal_grant,grant_year,end_year,grant_amount)
                    VALUES(
            '$_POST[name]',
            '$_POST[synopsis]',
            '$_POST[description]',
            $featureflag,
            '$_POST[keywords]',
            $studentflag,
            '$_POST[students]',
            $enddate,
            $approved,
            0,
            '',
            $mod,
            0,0,0,0,0,0,
            $internal_grant,
            $_POST[grant_year],
            $_POST[end_year],
            $_POST[grant_amount])";
    $result = $db->Execute($sql);
    if (!$result) {
        throw new Exception('Unable to insert new project into database');
    }
	$project_id = mysql_insert_id();
	if($result) $success=" <strong>Complete</strong>";
}
else if (isset($_POST['update'])) {
	$project_id = $_GET['id'];
	if (isset($_POST['feature'])) $featureflag = 1;
	else $featureflag = 0;
	if (isset($_POST['studentflag'])) $studentflag = 1;
	else $studentflag = 0;
	if (isset($_POST['approved'])) $approved=1; else $approved = 0;
	if (isset($_POST['internal_grant'])) $internal_grant=1; else $internal_grant = 0;
	$tmp_date = explode("/", $_POST['enddate']);
	$enddate = mktime(0,0,0,$tmp_date[1],$tmp_date[0],$tmp_date[2]);
    $mod=date('Y-m-d');
    //get the existing one
    $sql="SELECT * FROM projects WHERE project_id=$project_id";
    $proj=$db->GetRow($sql);
    if($proj){
        /*if($proj['ObjectID']==0){
            //Not set yet so need to generate
            $sql="SELECT MAX(ObjectID)as max from projects where 1";
            $max=$db->GetRow($sql);
            $objectid=$max['max']+1;
        }*/
        //else $objectid=$proj['ObjectID'];
	    if(mysqlDelete("projects_associated", "project_id=$project_id"));
	    $values = array('name'=>addslashes($_POST['name']), 'end_date'=>$enddate, 'synopsis'=>addslashes($_POST['synopsis']), 'description'=>addslashes($_POST['description']), 'feature'=>$featureflag, 'keywords'=>addslashes($_POST['keywords']), 'studentproj'=>$studentflag, 'student_names'=>addslashes($_POST['students']), 'approved'=>$approved,'modified'=>$mod,'internal_grant'=>$internal_grant,'grant_year'=>$_POST['grant_year'],'end_year'=>$_POST['end_year'], 'grant_amount'=>$_POST['grant_amount']); 
	    if(mysqlUpdate("projects", $values, "project_id=$project_id")) $success=" <strong>Project Updated</strong>";
    }
}
else if (isset($_GET['delete'])) {
	mysqlDelete("projects_associated", "project_id=$_GET[id]");
	if(mysqlDelete("projects", "project_id=$_GET[id]")) $success=" <strong>Project Deleted</strong>";
}
if(isset($_POST['add']) || isset($_POST['update'])) {
	#deal with problem where user may have selected subtopics AND parent. Causes multiple hits later
	#eliminate any subtopics IF the parent is selected
    /*
	if(isset($_POST['topics_research'])) {
		$topics2 = $_POST['topics_research'];
		$topics_research=NULL;
		foreach($topics2 as $cur_topic) {
			$topic_row = mysqlFetchRow("topics_research","topic_id = $cur_topic");
			if(is_array($topic_row)) {
				if($topic_row['level'] == 1) $topics_research[]=$cur_topic;
				else if(!in_array($topic_row['parent_id'],$topics2)) $topics_research[]=$cur_topic;
			}
		}
	}
    */
	//print_r($topics2);print_r($topics_research);
	$table_list = array('researchers','topics_research', 'departments');
	foreach($table_list as $table_name) {
		if(isset($_POST[$table_name])) {
			foreach($_POST[$table_name] as $index){
				if(!is_array(mysqlFetchRow("projects_associated", "project_id=$project_id AND object_id=$index AND table_name='$table_name'"))) {
					if($index != "") {
						$values = array('null', $project_id, $index, $table_name);
						if(mysqlInsert("projects_associated", $values));
					}
				}
			}
		}
	}
}
if (!isset($_REQUEST['section'])) $_REQUEST['section']='view';
if (isset($_REQUEST['section'])) {
	if(!isset($success)) $success="";
	switch($_REQUEST['section']){
		case "view":  
            if(isset($_REQUEST['sort'])) $sort=$_REQUEST['sort'];
             else $sort='approved';
             if(isset($_REQUEST['dir'])) {
             if($_REQUEST['dir']=='ASC') $dir='ASC';
                else $dir='DESC';
             }
             else $dir='ASC'; //default
    
			$output = "";
				$values = mysqlFetchRows("projects","1  ORDER BY $sort $dir");		
				if(is_array($values)) {			
					//$output.="<tr><td bgcolor='#000000'  style='font-size=12px; font-weight=bold; color:white;' colspan=4> $uc_name[fullname]</td></tr>";
					//Load associated researchers into an extra element - just the first one - for sorting
					
					foreach($values as $index) {
						if ($index['feature'] == 1) $featureflag = "Y";
						else $featureflag = "N";
						if ($index['approved']) $acolor='#D7D7D9'; else $acolor='#FF6666';
						if($index['internal_grant']) $acolor='#6666FF'; else $acolor='#D7D7D9';
						$objects = mysqlFetchRowsOneCol("projects_associated", "object_id", "project_id=$index[project_id] AND table_name='topics_research'");
						if(is_array($objects)) $topics_set = "#33FF33"; else $topics_set = "#FF3333";
	                    $sql="SELECT CONCAT(users.last_name,',&nbsp',users.first_name,'<br>') as uname FROM projects_associated as pa LEFT JOIN users on(users.user_id=pa.object_id) WHERE pa.project_id=$index[project_id] and pa.table_name = 'researchers' ";
                        //echo $sql;
                        $peoplelist='';
                        $people=$db->getAll($sql);
                        if(count($people)>0){
                            foreach($people as $person){
                                $peoplelist.=$person['uname'];
                            }
                        }
						
						$output .= "
							<tr>
								<td bgcolor='#E09731'><a style='color:white' href='projects.php?section=update&id=$index[project_id]'>Update</a></td>
								<td bgcolor='$acolor'>$index[name]</td>
								<td bgcolor='#D7D7D9'>$peoplelist</td>
								<td align='center' bgcolor='#D7D7D9'>$featureflag</td>
								<td bgcolor='$topics_set'>$index[ObjectID]</td>
								<td bgcolor='#D7D7D9'>$index[synopsis]</td>
							</tr>";
							
							//Grab papers linked
                            /*
                            
							$sql="SELECT * FROM projects_cvitems WHERE project_id=$index[project_id]";
							$items=$db->getAll($sql);
							if(count($items)>0){
								foreach($items as $item){
									if($item['info']!='') $output.="
									<tr>
									   <td bgcolor='#D7D7D9' colspan='3'></td><td bgcolor='#D7D7D9' colspan='3'>$item[info]</td>
									</tr>
									";
								}
							}
                            */
					} #foreach
				} #if isarray
			
			if($dir=='ASC')$dir='DESC';
            else $dir='ASC';
			$hasharray = array('success'=>$success, 'output'=>$output, 'sort'=>$sort,'dir'=>$dir);
			$filename = 'templates/template-projects_view.html';		
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
			$values = mysqlFetchRows("users", "1 ORDER BY last_name,first_name");
			$researcher_options = "";
			if(is_array($values)) foreach($values as $index) $researcher_options .= "<option value='$index[user_id]'>$index[last_name], $index[first_name]</option>"; 
			$values = mysqlFetchRows("departments", "1 ORDER BY name");
			$department_options = "";
			if(is_array($values)) foreach($values as $index) $department_options .= "<option value='$index[department_id]'>$index[name]</option>"; 
			
			
				
			$hasharray = array('success'=>$success, 'topic_options'=>$topic_options, 'department_options'=>$department_options, 'researcher_options'=>$researcher_options);
			$filename = 'templates/template-projects_add.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
        break;
            
            
            
		case "update":
			$picture_button = (mysqlFetchRow("pictures_associated", "object_id=$_GET[id] AND table_name='projects'"))?
				"<br><br><button type='button' onClick=\"window.location='pictures-associate.php?section=update&id=$_GET[id]&table_name=projects'\">View Associated Images</button>":"";
			$project = mysqlFetchRow("projects", "project_id=$_GET[id]");  
			if ($project['feature'] == 1) $project_feature = "checked";
			else $project_feature = "";
			if ($project['studentproj'] == 1) $studentflag = "checked";
			else $studentflag = "";
			$project['end_date'] = date("j/n/Y", $project['end_date']);
			//-- Selects the Departments
			$objects = mysqlFetchRows("projects_associated", "project_id=$_GET[id] AND table_name='departments'");
			$departments = mysqlFetchRows("departments", "1 ORDER BY name");
			$department_options = "";
			$i=0;
			if(is_array($objects))foreach($objects as $object) $ids[] = $object['object_id'];
			if(is_array($departments)) {
				foreach($departments as $department) {
					if(isset($ids) && in_array($department['department_id'], $ids)) $department_options .= "<option selected value='$department[department_id]'> $department[name]</option>"; 
					else $department_options .= "<option value='$department[department_id]'>$department[name]</option>";
					++$i;
				}
			}
            
            //grant Year 
            $grant_year_options='';
            for($year=2011;$year<=2017;$year++){
                if($project['grant_year']==$year) $selected='selected'; else $selected='';
                
                $grant_year_options.="<option value='$year' $selected>$year</option>/n";
            }
            $end_year_options='';
            for($year=2011;$year<=2017;$year++){
                if($project['end_year']==$year) $selected='selected'; else $selected='';
                
                $end_year_options.="<option value='$year' $selected>$year</option>/n";
            }
            
			//-- Selects the Researchers
			$objects = mysqlFetchRows("projects_associated", "project_id=$_GET[id] AND table_name='researchers'");
			$researchers = mysqlFetchRows("users", "1 ORDER BY last_name,first_name");
			$researcher_options = "";
			unset($ids); $i=0;
			if(is_array($objects))foreach($objects as $object) $ids[] = $object['object_id'];
			if(is_array($researchers)) {
				foreach($researchers as $researcher) {
					if(isset($ids) && in_array($researcher['user_id'], $ids)) $researcher_options .= "<option selected value='$researcher[user_id]'>$researcher[last_name], $researcher[first_name] </option>"; 
					else $researcher_options .= "<option value='$researcher[user_id]'>$researcher[last_name], $researcher[first_name] </option>"; 
					++$i;
				}
			} 
			//-- Selects the Topics
			$objects = mysqlFetchRowsOneCol("projects_associated", "object_id", "project_id=$_GET[id] AND table_name='topics_research'");
			$topics = mysqlFetchRows("topics_research", "1 ORDER BY name");
			$topic_options = ""; 
			if(is_array($objects)) foreach($objects as $object) $ids[] = $object['topic_id'];
			else $objects=array("xxx"); //in case no topics associated			
			if(is_array($topics)) {
				foreach($topics as $topic) {
					if(@in_array($topic['topic_id'], $objects)) $topic_options .= "<option value='$topic[topic_id]' selected>$topic[name]</option>";
					else $topic_options .= "<option value='$topic[topic_id]'>$topic[name]</option>";
					 
					 
				}
			}	
            
            
			
			#set the UC Name
			
			if($project['approved'] ==1) $approved="checked"; else $approved="";
            if($project['internal_grant'] ==1) $internal_grant="checked"; else $internal_grant="";
			
			$hasharray = array(     'id'=>$project['project_id'], 
                                    'name'=>$project['name'], 
                                    'enddate'=>$project['end_date'], 
                                    'synopsis'=>$project['synopsis'], 
                                    'description'=>$project['description'],
							        'department_options'=>$department_options, 
                                    'topic_options'=>$topic_options, 'researcher_options'=>$researcher_options, 
							        'picture_button'=>$picture_button, 
                                    'project_feature'=>$project_feature, 
                                    'studentflag'=>$studentflag, 
                                    'students'=>$project['student_names'], 
                                    'keywords'=>$project['keywords'], 
                                    'approved'=>$approved,
                                    'internal_grant'=>$internal_grant,
                                    'grant_year_options'=>$grant_year_options,
                                    'end_year_options'=>$end_year_options,
                                    'grant_amount'=>$project['grant_amount']
                                    );
			$filename = 'templates/template-projects_update.html';
			$parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
			echo $parsed_html_file;
            break;
            
            
            case "where":
                $table=$country_options=$state_options='';
                //Build a list of projects to choose from
                $projects= mysqlFetchRows("projects", "1 ORDER BY name");
                $project_options='';
                if(is_array($projects)) foreach($projects as $project){
                    $selected='';
                    if(isset($_REQUEST['project_id'])) if($_REQUEST['project_id']== $project['project_id']) $selected='selected'; 
                    if($project['country_code']!='' || $project['state_code']!='') $project_options.="<option value='$project[project_id]' $selected>*** $project[name]</option>\n";
                    else $project_options.="<option value='$project[project_id]' $selected>$project[name]</option>\n";
                }
                
                if(isset($_REQUEST['project_id']))
                {
                    $sql="SELECT projects.*, cas_countries.name as country, cas_provinces_states.name as state_name FROM projects LEFT JOIN cas_countries on LEFT(projects.country_code,2)=cas_countries.country_code LEFT JOIN cas_provinces_states on projects.state_code=cas_provinces_states.state_code WHERE project_id=$_REQUEST[project_id]";
                    
                    
                    $project_locs = $db->GetAll($sql);
                     
                    $table='';
                    if(is_array($project_locs)) {
                        //display a table of projects and locations with an option to delete
                        $table="<table border='1'>\n";
                        foreach($project_locs as $project_loc){
                            $table.="<tr><td>$project_loc[country]</td><td>$project_loc[state_name]</td></tr>\n";
                        }
                        $table.="</table >";
                    }
                    //add section
                    $country_options='';
                    $countries=mysqlFetchRows('cas_countries',"1 order by name");
                    foreach($countries as $country){
                        $selected='';
                        if(isset($_REQUEST['country_code'])) if($country['country_code']== $_REQUEST['country_code']) $selected='selected';
                        $country_options.="<option value='$country[country_code]' $selected>$country[name]</option>\n";
                    }
                    
                    $state_options='';
                    //echo ($_REQUEST['country_code']);
                    if(isset($_REQUEST['country_code'])) if($_REQUEST['country_code'] != '0'){
                        $states=mysqlFetchRows('cas_provinces_states',"country_code='$_REQUEST[country_code]' order by name");
                        if(is_array($states)) foreach($states as $state){
                            $state_options.="<option value='$state[state_code]' >$state[name]</option>\n";
                        }
                    }
                    
                    
                }//if isset project_id
                $hasharray = array(     'project_options'=>$project_options,
                                        'table'=>$table,
                                        'country_options'=>$country_options,
                                        'state_options'=>$state_options,
                                        'success'=>$success);
                                        
                $filename = 'templates/template-projects_where.html';
                $parsed_html_file = $template->loadTemplate($filename,$hasharray,"HTML");
                echo $parsed_html_file;
            break;
            
	} 
}
//-- Footer File
include("templates/template-footer.html");
?>
