# Cache visited pages during the same session
#Turbolinks.enableTransitionCache();

FADE_SPEED = 150

# Show the loading image when pages are in transition
$(document)
  .on 'page:fetch', ->
    $('#loading').fadeIn FADE_SPEED
  .on 'page:load', ->
    $('#loading').fadeOut FADE_SPEED

$.fn.livePreview = ->
  @each (i, element) ->
    row = $(element)
    field = row.find('textarea')
    preview = row.find('.rendered-html')

    markdown = (source, context) ->
      marked source, (err, result) ->
        throw err if err
        context.html result

    markdown field.text(), preview

    field.on 'keyup', ->
      markdown $(this).text(), preview

jQuery ->
  # Enable Zurb Foundation
  $(document).foundation()

  $('.input.preview').livePreview()

  if $('#license').length
    $.get '/license.txt', (response) -> $('#license').text(response)
