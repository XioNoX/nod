<?php
header("Access-Control-Allow-Origin: *");
require_once "lib/base.php";
require_once "controllers/pois.php";
require_once "controllers/activities.php";

require_once "config.php";

#Defining all the routes of the application 
F3::route('POST /activities', 'activities::compute');
F3::route('GET /activities', 'activities::compute'); //XXX For debug purpose only
F3::route('GET /pois/@id', 'pois::single');


#API routes 
# need to create a controller and a route for each resource of the application
//F3::route('GET /api/poi','poi::specific');
//F3::route('GET /api/poi/@id','poi::show');
//F3::route('GET /api/parks','parks::all');
//F3::route('GET /api/parks/@id','park::show');

F3::run();
?>
