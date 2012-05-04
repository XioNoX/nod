//defining custom icons for the page 
var NodIcon = L.Icon.extend({
  iconUrl: 'images/map/icon.png',
  shadowUrl: 'images/map/icon-shadow.png'
});

var currentMarker = null;
var map = null; //the main map of the page
var markerLayer = null;
var timeline = null; //TODO create an object timeline that can handle adding / deleting and reordering events

var ajaxFormOptions = { 
  success: function(responseText, textStatus, xhr, form) {
    if (textStatus === "success") {
      var arrayOfPoi = JSON.parse(responseText);
      if (markerLayer) markerLayer.clearLayers();
      markerLayer = new L.LayerGroup();
      for (index in arrayOfPoi) {
        poi = arrayOfPoi[index];
        var icon = iconForPoi(poi);
        var latLong = new L.LatLng(poi.latitude, poi.longitude);
        var marker = new L.Marker(latLong, {icon:icon}).bindPopup("Pour m'ajouter à votre timeline faites moi glisser jusqu'à elle ");
        marker.poi = poi;
        marker.on("click", function(event) { 
             if (currentMarker != null) {
                currentMarker.setIcon(iconForPoi(this.poi));
             }
             currentMarker = this;
             this.setIcon(new NodIcon("images/map/selected-icon.png"));
             initDraggingEventListeners();
        }, false);

        marker.on('click', generateMarkerClickCallback(poi));
        markerLayer.addLayer(marker);
      }
      map.addLayer(markerLayer);
      //registrering the event handler for the drag and drop
      initDraggingEventListeners();
    }
  } 
};

function iconForPoi(poi) {
  return new NodIcon("images/map/"+poi.type+"-icon.png");
}

function addDraggingEventListener(element) {
  element.addEventListener('dragstart', function(e) { 
    openTimeline();
    showDragMessage();
  }, false);
}

function initDraggingEventListeners() {
  $(".leaflet-marker-icon").each(function(index, element) {addDraggingEventListener(element)}, false);
}

function openTimeline() {
  $("#accordion").accordion("activate", ".timeline");
}

function closeDescription() {
  $("#description").hide("slide", {direction:"down"}, 500);
}

function showDragMessage() {

}

/***** DATA STORAGE *****/
function savePoiToTimeline(poi) {
  //TODO 
}

//return a function generated from a poi
//the returned function take an event as a parameter 
//the returned function is initialized with a poi thanks to a closure
function generateMarkerClickCallback(poi) {
  var generatedFunction = function(event) {
    var containerDiv = $("#description");
    var titleDiv = $("#poi-title");
    var descDiv = $("#poi-description");

    containerDiv.show("slide", {direction:"down"}, 500);
    titleDiv.html("<h2>"+poi.label+"</h2>");
    descDiv.html(poi.description);
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
    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(ajaxFormOptions);

    $('#accordion').accordion();

    //adding the dropping event on the timeline
    var timeline = document.getElementById("timeline-content");
    timeline.addEventListener("drop", function(e) { e.preventDefault(); alert("TODO"); return false; }, false); 
    timeline.addEventListener("dragover", function(e) { e.preventDefault(); }, false); 
    /***** MAP *******/
    initMap();
  }
);
