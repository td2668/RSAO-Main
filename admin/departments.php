<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");
//include("includes/garbage_collector.php");
$template = new Template;
//require("security.php");

error_reporting(E_ALL);
ini_set('display_errors', '1');

include("html/header.html");
if (isset($_REQUEST['add'])) {
    $values = array(
        'null',
        $_REQUEST['name'],
        $_REQUEST['shortname'],
        $_REQUEST['division_id'],
        $_REQUEST['chair'],
        $_REQUEST['director']
    );
    if (mysqlInsert("departments", $values)) {
        $success = " <strong>Complete</strong>";
    }
}
else {
    if (isset($_REQUEST['update'])) {
        $values = array(
            'name'        => $_REQUEST['name'],
            'shortname'   => $_REQUEST['shortname'],
            'division_id' => $_REQUEST['division_id'],
            'chair'       => $_REQUEST['chair'],
            'director'    => $_REQUEST['director']
        );
        if (mysqlUpdate("departments", $values, "department_id=$_REQUEST[id]")) {
            $success = " <strong>Department Updated</strong>";
        }
    }
    else {
        if (isset($_REQUEST['delete'])) {
            if (mysqlDelete("departments", "department_id=$_REQUEST[id]")) {
                $success = " <strong>Department Deleted</strong>";
            }
        }
    }
}

if (isset($_REQUEST['section'])) {
    if (!isset($success)) {
        $success = "";
    }
    switch ($_REQUEST['section']) {
        case "view":
            $values = mysqlFetchRows("departments", "1 order by name");
            $output = "";
            if (is_array($values)) {
                foreach ($values as $index) {
                    $division = mysqlFetchRow("divisions", "division_id=$index[division_id]");
                    if (is_array($division)) {
                        $div = $division['name'];
                    }
                    else {
                        $div = "--";
                    }
                    $chair = mysqlFetchRow("users", "user_id=$index[chair]");
                    if (is_array($chair)) {
                        $ch = "$chair[last_name], $chair[first_name]";
                    }
                    else {
                        $ch = " -- ";
                    }
                    $director = mysqlFetchRow("users", "user_id=$index[director]");
                    if (is_array($director)) {
                        $director = "$director[last_name], $director[first_name]";
                    }
                    else {
                        $director = "--";
                    }
                    $output .= "
						<tr>
							<td bgcolor='#E09731'><a style='color:white' href='departments.php?section=update&id=$index[department_id]'>Update</a></td>
							<td bgcolor='#D7D7D9'>$index[name]</td>
							<td bgcolor='#D7D7D9'>$div</td>
							<td bgcolor='#D7D7D9'>$ch</td>
							<td bgcolor='#D7D7D9'>$director</td>
						</tr>";
                }
                $hasharray = array(
                    'success'=> $success,
                    'output' => $output
                );
                $filename = 'templates/template-departments_view.html';
            }
            else {
                $hasharray = array('title'=> "Departments");
                $filename = 'includes/error-no_records.html';
            }
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
        case "add":
            $division_options = "";
            $user_options = "";
            $divisions = mysqlFetchRows("divisions", "1 order by name");
            if (is_array($divisions)) {
                foreach ($divisions as $division) {
                    $division_options .= "<option value='$division[division_id]'>$division[name]</option>\n";
                }
            }
            $users = mysqlFetchRows("users", "1 order by last_name,first_name");
            if (is_array($users)) {
                foreach ($users as $user) {
                    if($user['last_name'] && $user['first_name']) {
                        $user_options .= "<option value='$user[user_id]'>$user[last_name], $user[first_name]</option>\n";
                    }
                }
            }
            $hasharray = array(
                'success'         => $success,
                'division_options'=> $division_options,
                'user_options'    => $user_options
            );
            $filename = 'templates/template-departments_add.html';
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
        case "update":
            $values = mysqlFetchRow("departments", "department_id=$_REQUEST[id]");
            $division_options = "";
            $user_options = "";
            $director_options = "";
            $divisions = mysqlFetchRows("divisions", "1 order by name");
            if (is_array($divisions)) {
                foreach ($divisions as $division) {

                    if ($values['division_id'] == $division['division_id']) {
                        $dsel = "selected";
                    }
                    else {
                        $dsel = "";
                    }
                    $division_options .= "<option value='$division[division_id]' $dsel>$division[name]</option>\n";
                }
            }
            $users = mysqlFetchRows("users", "1 order by last_name,first_name");
            if (is_array($users)) {
                foreach ($users as $user) {
                    if ($values['chair'] == $user['user_id']) {
                        $usel = "selected";
                    }
                    else {
                        $usel = "";
                    }
                    if($user['last_name'] && $user['first_name']) {
                        $user_options .= "<option value='$user[user_id]' $usel>$user[last_name], $user[first_name]</option>\n";
                    }
                }
            }
            if (is_array($users)) {
                foreach ($users as $user) {
                    if ($values['director'] == $user['user_id']) {
                        $usel = "selected";
                    }
                    else {
                        $usel = "";
                    }
                    if($user['last_name'] && $user['first_name']) {
                        $director_options .= "<option value='$user[user_id]' $usel>$user[last_name], $user[first_name]</option>\n";
                    }
                }
            }
            $hasharray = array(
                'id'              => $values['department_id'],
                'name'            => $values['name'],
                'shortname'       => $values['shortname'],
                'division_options'=> $division_options,
                'user_options'    => $user_options,
                'director_options'=> $director_options
            );
            $filename = 'templates/template-departments_update.html';
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
    }
}
//-- Footer File
include("templates/template-footer.html");