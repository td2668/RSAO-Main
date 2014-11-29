<?php



include("includes/config.inc.php");
include("includes/functions-required.php");
include("includes/class-template.php");

$tmpl=loadPage("index", 'ORS Admin');

$tmpl->displayParsedTemplate('page');

