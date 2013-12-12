var type_timeout;
var ctr = 0;
var old_value = "";

Ajax.Responders.register({
  onCreate: function(){ Element.show('spinner')},
  onComplete: function(){Element.hide('spinner')}
});

function process_markers(data) {
  var data = eval(data);
  
  if (data.length == 0)
  {
    $('no_results').show()
    $('search_instruction').show()
    $('terms_no_results').innerHTML = '"' + $('terms').value + '"'
  }
}

function search_and_update() {
  input = $('terms')
  new Ajax.Updater('spots_list', '/search.html', {
    method: 'get',
    parameters: {terms: input.value}
  })
  
  new Ajax.Request('/search.json', {
    method: 'get',
    parameters: {terms: input.value},
    onSuccess: function(transport) {
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