<?php

class pois {
  
/*called for the url /poi/(id)
return a single poi */
   static function single() {
      $id = F3::get('PARAMS["id"]');
      $poi = DB::sql("SELECT * from points_of_interest
          INNER JOIN gps 
          ON gps.id = points_of_interest.gps_id
          WHERE points_of_interest.id=$id");


      $longitude = str_replace(".", ",", $poi[0]['longitude']);
      $latitude = str_replace(".", ",", $poi[0]['latitude']);
      $url = "https://open.tan.fr/ewp/arrets.json/".$latitude."/".$longitude;
     
      $ch = curl_init($url);
      curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
      curl_setopt( $ch, CURLOPT_HEADER, 0 );
      $page = curl_exec($ch);
      curl_close($ch);
      echo $page;
   }
   
   static function query($id = NULL) {
   	if (F3::get('include_poi') != TRUE) return;
   	if(isset($id)) return single($id);
   	return specific($id);
   }
   
  
}

?>
