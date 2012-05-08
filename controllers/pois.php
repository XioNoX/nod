<?php

class pois {
  
/*called for the url /poi/(id)
return a single poi */
   static function single() {
      $id = F3::get('PARAMS["id"]');
      $poi = DB::sql("SELECT * from points_of_interest
			WHERE id=$id");
      echo json_encode($poi);
   }
   
   static function query($id = NULL) {
   	if (F3::get('include_poi') != TRUE) return;
   	if(isset($id)) return single($id);
   	return specific($id);
   }
   
  
}

?>
