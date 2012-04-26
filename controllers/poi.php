<?php

class poi {
  
/*called for the url /poi.
lists all the poi in the database */
  static function index() {
      #TODO protect parameters from xss
      $poi = new Axon("points_of_interest"); 
      $poi = DB::sql("SELECT * from points_of_interest INNER JOIN gps
	  		ON points_of_interest.gps_id = gps.id");
      $output = isset($_GET["output"]) ? $_GET["output"] : "";
      switch ($output) {
        case "jsonp":
          $callback = isset($_GET["callback"]) ? $_GET["callback"] : "callback";
          echo "$callback(\"".addslashes(json_encode($poi))."\");";
          break;
        default:
          echo json_encode($poi);
      }
   }
   
   
/*called for the url /poi/(id)
return a single poi */
   static function show() {
      $id = F3::get('PARAMS["id"]');
      echo F3::get('GET["id"]');
      $poi = DB::sql("SELECT * from points_of_interest
			WHERE id=$id");
      echo json_encode($poi);
   }
  
}

?>
