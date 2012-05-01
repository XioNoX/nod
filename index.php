<?php

require_once "lib/base.php";
require_once "controllers/pois.php";
require_once "controllers/parks.php";
require_once "controllers/activities.php";

require_once "config.php";

#Defining all the routes of the application 
F3::route('POST /activities', 'activities::compute');
F3::route('GET /activities', 'activities::compute'); //XXX For debug purpose only


#API routes 
# need to create a controller and a route for each resource of the application
//F3::route('GET /api/poi','poi::specific');
//F3::route('GET /api/poi/@id','poi::show');
//F3::route('GET /api/parks','parks::all');
//F3::route('GET /api/parks/@id','park::show');

F3::run();
?>
