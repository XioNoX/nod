<?php 

class home {
  
  static function index() {
    F3::set('content', 'views/home.html');
    echo Template::serve('views/layout.html');
  }
  
}

?>
