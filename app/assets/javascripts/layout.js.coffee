# Cache visited pages during the same session
#Turbolinks.enableTransitionCache();

FADE_SPEED = 150

# Show the loading image when pages are in transition
$(document)
  .on 'page:fetch', ->
    $('#loading').fadeIn FADE_SPEED
  .on 'page:load', ->
    $('#loading').fadeOut FADE_SPEED

# Enable Zurb Foundation
jQuery -> $(document).foundation()
