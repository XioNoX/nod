<?php
  
class activities {
    
  static function compute() {
    $form_values = F3::scrub($_POST); //TODO Protect against XSS
    //Declaration of what's requested based on the POST fields
    F3::set('activities_search', TRUE);
    if(isset($form_values["itinerary"])) F3::set('itinerary',TRUE);
    if(isset($form_values["all"])) F3::set('all',TRUE);
    if(isset($form_values["bars"])) F3::set('include_bars',TRUE);
    if(isset($form_values["poi"])) F3::set('include_poi',TRUE); //Display _all_ the POIs
    if(isset($form_values["parks"])) F3::set('include_parks',TRUE);
    if(isset($form_values["restaurants"])) F3::set('include_restaurants',TRUE);
    if(isset($form_values["cultural_venues"])) F3::set('include_cultural_venues',TRUE);
    if(isset($form_values["concert"])) F3::set('include_concert',TRUE);
    if(isset($form_values["date_start"])) F3::set('date_start',$form_values["date_start"]);
    if(isset($form_values["date_end"])) F3::set('date_end',$form_values["date_end"]);

    
    $poi_parks = parks::query();
    $poi_poi = poi::query();
    $poi_restaurants = restaurants::query();
    // etc...

    $poi = array_unique(array_merge($poi_parks,$poi_poi));    
    
    if(F3::get('itinerary') == TRUE) //If looking for an itinerary, sort/filter the POIs
    	$poi = itinerary::compute($poi);

    $output = isset($_GET["output"]) ? $_GET["output"] : "";
    switch ($output) {
    	case "jsonp":
    		$callback = isset($_GET["callback"]) ? $_GET["callback"] : "callback";
    		header("Content-type: text/javascript");
    		echo "$callback(\"".addslashes(json_encode($poi))."\");";
    		break;
    	default:
    		return json_encode($poi);
    }
  }
   
}

?>
