<?php
include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");

$template = new Template;

include("html/header.html");

if (isset($_REQUEST['add'])) {
    $values = array(
        'null',
        $_REQUEST['name'],
        $_REQUEST['dean'],
        $_REQUEST['associate_dean']
    );
    if (mysqlInsert("divisions", $values)) {
        $success = " <strong>Complete</strong>";
    }
}
else {
    if (isset($_REQUEST['update'])) {
        $values = array(
            'name'          => $_REQUEST['name'],
            'dean'          => $_REQUEST['dean'],
            'associate_dean'=> $_REQUEST['associate_dean']
        );
        if (mysqlUpdate("divisions", $values, "division_id=$_REQUEST[id]")) {
            $success = " <strong>Division Updated</strong>";
        }
    }
    else {
        if (isset($_REQUEST['delete'])) {
            if (mysqlDelete("divisions", "division_id=$_REQUEST[id]")) {
                $success = " <strong>Division Deleted</strong>";
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
            $values = mysqlFetchRows("divisions", "1 order by name");
            $output = "";
            if (is_array($values)) {
                foreach ($values as $index) {

                    $dean = mysqlFetchRow("users", "user_id=$index[dean]");
                    if (is_array($dean)) {
                        $ch = "$dean[last_name], $dean[first_name]";
                    }
                    else {
                        $ch = " --- ";
                    }

                    $associateDean = mysqlFetchRow("users", "user_id=$index[associate_dean]");
                    if (is_array($associateDean)) {
                        $assoc = "$associateDean[last_name], $associateDean[first_name]";
                    }
                    else {
                        $assoc = " --- ";
                    }

                    $output .= "
						<tr>
							<td bgcolor='#E09731'><a style='color:white' href='divisions.php?section=update&id=$index[division_id]'>Update</a></td>
							<td bgcolor='#D7D7D9'>$index[name]</td>
							<td bgcolor='#D7D7D9'>$ch</td>
                            <td bgcolor='#D7D7D9'>$assoc</td>
						</tr>";
                }
                $hasharray = array(
                    'success'=> $success,
                    'output' => $output
                );
                $filename = 'templates/template-divisions_view.html';
            }
            else {
                $hasharray = array('title'=> "Divisions");
                $filename = 'includes/error-no_records.html';
            }
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
        case "add":
            $user_options = "";
            $users = mysqlFetchRows("users", "1 order by last_name,first_name");
            if (is_array($users)) {
                foreach ($users as $user) {
                    if($user['last_name'] && $user['first_name']) {
                        $user_options .= "<option value='$user[user_id]'>$user[last_name], $user[first_name]</option>\n";
                    }
                }
            }
            $hasharray = array(
                'success'     => $success,
                'user_options'=> $user_options
            );
            $filename = 'templates/template-divisions_add.html';
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
        case "update":
            $values = mysqlFetchRow("divisions", "division_id=$_REQUEST[id]");
            $user_options = "";

            $users = mysqlFetchRows("users", "1 order by last_name,first_name");

            if (is_array($users)) {
                foreach ($users as $user) {
                    if ($values['dean'] == $user['user_id']) {
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
            $deanArray = array(
                'id'          => $values['division_id'],
                'name'        => $values['name'],
                'dean_options'=> $user_options
            );

            $user_options = "";
            if (is_array($users)) {
                foreach ($users as $user) {
                    if ($values['associate_dean'] == $user['user_id']) {
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
            $associateDeanArray = array(
                'id'               => $values['division_id'],
                'name'             => $values['name'],
                'assocdean_options'=> $user_options
            );

            $hasharray = array(
                'id'                => $_REQUEST['id'],
                'name'              => $values['name'],
                'dean_options'      => $deanArray,
                'assocdean_options' => $associateDeanArray
            );

            $filename = 'templates/template-divisions_update.html';
            $parsed_html_file = $template->loadTemplate($filename, $hasharray, "HTML");
            echo $parsed_html_file;
            break;
    }
}
//-- Footer File
include("templates/template-footer.html");