<?php
  
class activities {
    
  static function compute() {
    $form_values = F3::scrub($_POST); //TODO Protect against XSS
    $query = ""; //the query that will be build depending on the parameters of the request

    F3::set('activities_search', TRUE);
    if(isset($form_values["date_start"])) F3::set('date_start',$form_values["date_start"]); //TODO: not used for the moment
    if(isset($form_values["date_end"])) F3::set('date_end',$form_values["date_end"]); //TODO: not used for the moment

    if(isset($form_values["all"])) {
      $query = "SELECT * from points_of_interest INNER JOIN gps
              ON points_of_interest.gps_id = gps.id";
    } else {
      //Declaration of what's requested based on the POST fields
      $queried_types = array(); //the array containing all the types of poi we want to retreive
      $possible_types = array("itinerary",
                              "bars", 
                              "parks", 
                              "restaurants", 
                              "cultural_venues", 
                              "concerts"); //the array containing all the types of POI available

      //checking the types the user has asked for
      foreach($possible_types as $type) {
        if(isset($form_values[$type])) array_push($queried_types, $type);
      }

      //building the query
      $query = "SELECT * from points_of_interest INNER JOIN gps
              ON points_of_interest.gps_id = gps.id
              WHERE points_of_interest.type IN ('".implode("', '", $queried_types)."');";
    }
    //if(isset($form_values["poi"])) F3::set('include_poi',TRUE); //Display _all_ the POIs

  	$pois = DB::sql($query);
    
    //if(F3::get('itinerary') == TRUE) //If looking for an itinerary, sort/filter the POIs
    //	$poi = itinerary::compute($poi);

    $output = isset($_GET["output"]) ? $_GET["output"] : "";
    switch ($output) {
    	case "jsonp":
    		$callback = isset($_GET["callback"]) ? $_GET["callback"] : "callback";
    		header("Content-type: text/javascript");
    		echo "$callback(\"".addslashes(json_encode($pois))."\");";
    		break;
    	default:
    		echo json_encode($pois);
    }
  }
   
}

?>
