<?php

echo is_currency('$123,123.2x');

function is_currency( $v )
{
$v = preg_replace("/[^0-9.]+/","",$v);
return round($v);
}
?>