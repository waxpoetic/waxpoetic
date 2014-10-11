# Define a google map to the event if it's present.
$.fn.generateMap = ->
  @each (i, element) ->
    event = $(element)
    latitude =  event.attr 'data-lat'
    longitude = event.attr 'data-long'
    event.find('.map').googleMap @attributes

jQuery -> $('#event').generateMap()
