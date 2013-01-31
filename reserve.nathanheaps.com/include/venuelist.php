<?php
require('./venuemap.php');
$tpl = array(
	'PAGE_NAME' => "venuelist",
	'PAGE_TITLE' => "On-campus Venues",
	'PAGE_HEADER' => "On-campus Venues",
	'CUSTOM_CSS' => array(
		"/css/pages/venuelist.css"
		),
	'CUSTOM_JS' => array()
);


include('../static/html/header.htm');

include('../static/html/venues.htm');

include('../static/html/footer.htm');


?>