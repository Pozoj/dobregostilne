var move_timeout;

function movement_update() {
  new Ajax.Updater('spots_list', '/spots_in_area', {
    method: 'get',
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