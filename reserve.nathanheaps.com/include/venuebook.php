<?php
require('./venuemap.php');

$url = explode("/", $_SERVER["REQUEST_URI"]);
$venueId = $url[2];

$venueName = $venueList[$venueId];
$tpl = array(
	'PAGE_NAME' => "venuebook-". $venueId,
	'PAGE_TITLE' => "Book " . $venueName,
	'PAGE_HEADER' => "DO NOT USE THIS",
	'CUSTOM_CSS' => array(
		"/css/pages/venuebook.css"),
	'CUSTOM_JS' => array(
		"/js/extern/jquery.validate/1.11.0.min.js",
		"/js/extern/jquery.validate/1.11.0.additional-methods.min.js",
		"/js/pages/book.js")
);


include('../static/html/header.htm');

include('../static/html/venue/book.htm');

include('../static/html/footer.htm');

?>