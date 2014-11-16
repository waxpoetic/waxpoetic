# Cache visited pages during the same session
Turbolinks.enableTransitionCache();

$(document).on 'page:load', ->
  # Enable Zurb Foundation
  $(document).foundation()

  # Destroy row in nested attr forms
  $('#track-fields .remove').undo()

  # Lazy-load images in thumbnail carousels
  $('.clearing-thumbs').slick(
    draggable: false,
    lazyLoad: 'ondemand',
    infinite: true
  )

# Only enable the loading image if the page was just loaded.
$(document).on 'ready', -> $('#loading').turboload(fadeSpeed: 150)
