var ajaxFormOptions = { 
  target: '#content',   
  success: function() { 
  } 
};

function initMap() {
    // Define the map to use from MapBox
    // This is the TileJSON endpoint copied from the embed button on your map
    var url = 'http://a.tiles.mapbox.com/v3/xionox.map-ef0s39bd.jsonp';

    // Make a new Leaflet map in your container div
    var map = new L.Map('mapbox')  // container's id="mapbox"

    // Center the map on Nantes, DC, at zoom 15
    .setView(new L.LatLng(47.215, -1.541), 13);

    // Get metadata about the map from MapBox
    wax.tilejson(url, function(tilejson) {
        // Add MapBox Streets as a base layer
        map.addLayer(new wax.leaf.connector(tilejson));
    });
}

function showPois () {
  $.get(APIURL + "poi", function(data, textStatus, jqXHR) {
    if (textStatus == "200")  {
      $("#content").html = data;
    }
  }); 
}

$(document).ready(
  function() {
    /******* AJAX FORMS *******/

    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(ajaxFormOptions);

   
    /***** MAP *******/
    initMap();
  }
);
