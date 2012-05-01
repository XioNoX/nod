<?php

class pois {
  
/*called for the url /poi.
lists all the poi in the database */
  static function specific() {
  	//if(F3::get('all') == TRUE) 
  	return DB::sql("SELECT * from points_of_interest INNER JOIN gps
	  		ON points_of_interest.gps_id = gps.id");

   }
   
   
/*called for the url /poi/(id)
return a single poi */
   static function single($id) {
      $poi = DB::sql("SELECT * from points_of_interest
			WHERE id=$id");
      return $poi;
   }
   
   static function query($id = NULL) {
   	if (F3::get('include_poi') != TRUE) return;
   	if(isset($id)) return single($id);
   	return specific($id);
   }
   
  
}

?>
