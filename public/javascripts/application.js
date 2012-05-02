//defining custom icons for the page 
var NodIcon = L.Icon.extend({
  iconUrl: 'images/map/icon.png',
  shadowUrl: 'images/map/icon-shadow.png'
});

var map = null; //the main map of the page
var markerLayer = null;

var ajaxFormOptions = { 
  success: function(responseText, textStatus, xhr, form) {
    if (textStatus === "success") {
      var arrayOfPoi = JSON.parse(responseText);
      if (markerLayer) markerLayer.clearLayers();
      markerLayer = new L.LayerGroup();
      var icon = new NodIcon();
      for (index in arrayOfPoi) {
        poi = arrayOfPoi[index];
        var latLong = new L.LatLng(poi.latitude, poi.longitude);
        var marker = new L.Marker(latLong, {icon:icon});
        marker.on('click', generateMarkerClickCallback(poi));
        markerLayer.addLayer(marker);
      }
      map.addLayer(markerLayer);
    }
  } 
};

//return a function generated from a poi
//the returned function take an event as a parameter 
//the returned function is initialized with a poi thanks to a closure
function generateMarkerClickCallback(poi) {
  var generatedFunction = function(event) {
    //TODO : open the panel with the description
    var descriptionDiv = $("#description");
    descriptionDiv.html("<h1>" + poi.label + "</h1><p>"+poi.description+"</p>");
  }
  return generatedFunction;
}

function initMap() {
    // Define the map to use from MapBox
    // This is the TileJSON endpoint copied from the embed button on your map
    var url = 'http://a.tiles.mapbox.com/v3/xionox.map-ef0s39bd.jsonp';

    // Make a new Leaflet map in your container div
    map = new L.Map('mapbox')  // container's id="mapbox"

    // Center the map on Nantes, DC, at zoom 15
    .setView(new L.LatLng(47.215, -1.541), 13);

    // Get metadata about the map from MapBox
    wax.tilejson(url, function(tilejson) {
        // Add MapBox Streets as a base layer
        map.addLayer(new wax.leaf.connector(tilejson));
    });
}

$(document).ready(
  function() {
    /******* AJAX FORMS *******/

    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(ajaxFormOptions);

    $('#accordion').accordion();

   
    /***** MAP *******/
    initMap();
  }
);
