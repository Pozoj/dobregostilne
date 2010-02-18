var type_timeout;
var google_map_markers = new Array();
var ctr = 0;
var old_value = "";

function process_markers(data) {
  var data = eval(data);
  var google_map_latlng_bounds = new GLatLngBounds();
  
  if (data.length == 0)
  {
    google_map_latlng_bounds
    google_map_latlng_bounds.extend(new GLatLng(46.1512410, 14.9954630));
    zoom = 8;
    $('no_results').show()
  }
  else
  {
    $('no_results').hide()
    data.each(function(spot) {
      google_map_latlng_bounds.extend(new GLatLng(spot.lat, spot.lng));
      google_map_markers[ctr] = new GMarker(new GLatLng(spot.lat, spot.lng));
      eval("marker_info_"+ctr+"=function() {google_map_markers["+ctr+"].openInfoWindowHtml('"+spot.html+"')}");
      GEvent.addListener(google_map_markers[ctr], 'click', eval("marker_info_"+ctr));
      google_map.addOverlay(google_map_markers[ctr]);    
      ctr++;
    })
    var zoom = google_map.getBoundsZoomLevel(google_map_latlng_bounds);
    if (zoom > 11) zoom = zoom - (zoom-11)    
  }

  
  google_map.setCenter(google_map_latlng_bounds.getCenter(), zoom);
}

function search_and_update() {
  input = $('terms')
  new Ajax.Updater('spots_list', '/search.html', {
    parameters: {terms: input.value}
  })
  
  new Ajax.Request('/search.json', {
    parameters: {terms: input.value},
    onSuccess: function(transport) {
      google_map.clearOverlays()
      process_markers(transport.responseText)
    }
  })
  
  
}

function handle_typing(e) {
  input = Event.element(e);
  if ( old_value != input.value )
  {
    old_value = input.value;
    if (input.value != "")
    {
      GEvent.clearListeners(google_map);
      if ( type_timeout ) {
        clearTimeout(type_timeout)
        type_timeout = null
      }
      type_timeout = setTimeout(search_and_update, 500)
    }
    else
    {
      search_and_update();
      movement_update();
      var move_timeout;

      function movement_update() {
        new Ajax.Updater('spots_list', '/spots_in_area', {
          parameters: { zoom: google_map.getZoom(), center_y: google_map.getCenter().y, center_x: google_map.getCenter().x }
        });
      }

      function handle_movement() {
        if (move_timeout)
        {
          clearTimeout(move_timeout)
          move_timeout = null
        }

        move_timeout = setTimeout(movement_update, 700)  
      }

      GEvent.addListener(google_map, "moveend", handle_movement);
    }
  }
}

var attach_events = function () {
  Event.observe("terms", "keyup", handle_typing)
}

Event.observe(window, 'load', attach_events)