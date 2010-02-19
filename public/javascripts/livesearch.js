var type_timeout;
var google_map_markers = new Array();
var google_map_icons = new Array();
var ctr = 0;
var old_value = "";

Ajax.Responders.register({
onCreate: function(){ Element.show('spinner')},
onComplete: function(){Element.hide('spinner')}
});

function get_map_icon(letter) {  
  icon = new GIcon();
  icon.image = "http://www.google.com/mapfiles/marker" + letter + ".png";
  icon.shadow = "http://www.google.com/mapfiles/shadow50.png";
  icon.iconSize = new GSize(20, 34);
  icon.shadowSize = new GSize(37, 34);
  icon.iconAnchor = new GPoint(6, 20);
  icon.infoWindowAnchor = new GPoint(5, 1);
  google_map_icons[google_map_icons.length] = icon
  return icon
}

function process_markers(data) {
  var data = eval(data);
  var google_map_latlng_bounds = new GLatLngBounds();
  
  if (data.length == 0)
  {
    google_map_latlng_bounds
    google_map_latlng_bounds.extend(new GLatLng(46.1512410, 14.9954630));
    zoom = 8;
    $('no_results').show()
    $('search_instruction').show()
    $('terms_no_results').innerHTML = '"' + $('terms').value + '"'
  }
  else
  {
    data.each(function(spot) {
      get_map_icon(spot.letter);
      google_map_latlng_bounds.extend(new GLatLng(spot.lat, spot.lng));
      google_map_markers[ctr] = new GMarker(new GLatLng(spot.lat, spot.lng), {icon: get_map_icon(spot.letter)});
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
      $('no_results').hide();
      $('search_notice').hide();
      $('search_instruction').hide();
      GEvent.clearListeners(google_map);
      if ( type_timeout ) {
        clearTimeout(type_timeout)
        type_timeout = null
      }
      type_timeout = setTimeout(search_and_update, 500)
    }
  }
}

var attach_events = function () {
  Event.observe("terms", "keyup", handle_typing)
  $('terms').focus()
}

Event.observe(window, 'load', attach_events)