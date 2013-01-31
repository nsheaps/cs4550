<?php
require('./venuemap.php');

$url = explode("/", $_SERVER["REQUEST_URI"]);
$venueId = $url[2];

$venueName = $venueList[$venueId];
$tpl = array(
	'PAGE_NAME' => "venuebook-". $venueId,
	'PAGE_TITLE' => "Book " . $venueName,
	'PAGE_HEADER' => "DO NOT USE THIS",
	'CUSTOM_CSS' => array(),
	'CUSTOM_JS' => array()
);


include('../static/html/header.htm');

include('../static/html/venue/book.htm');

include('../static/html/footer.htm');

?>