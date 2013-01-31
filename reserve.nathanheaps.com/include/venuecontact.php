<?php
require('./venuemap.php');

$venueId = explode("/", $_SERVER["REQUEST_URI"])[2];
$venueName = $venueList[$venueId];
$tpl = array(
	'PAGE_NAME' => "venuecontact-". $venueId,
	'PAGE_TITLE' => $venueName,
	'PAGE_HEADER' => "DO NOT USE THIS",
	'CUSTOM_CSS' => array(),
	'CUSTOM_JS' => array()
);


include('../static/html/header.htm');

include('../static/html/venue/' . $venueId . '/venueContact.htm');

include('../static/html/footer.htm');

?>