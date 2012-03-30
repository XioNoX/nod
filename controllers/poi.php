<?php

class poi {
  
/*called for the url /poi.
lists all the poi in the database */
  static function index() {
      #TODO protect parameters from xss
      $poi = new Axon("points_of_interest"); 
      $poi = $poi->afind();
      echo json_encode($poi);
   }
   
   
/*called for the url /poi/(id)
return a single poi */
   static function show() {
      $id = F3::get('PARAMS["id"]');
      echo F3::get('GET["id"]');
      echo "you have asked for the poi ".$id;
   }
  
}

?>
