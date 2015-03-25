jQuery ->
  RAILS_ENV = $('meta[name="environment"]').attr('content')
  FADE_SPEED = 150

  # Enable Zurb Foundation
  $(document).foundation()

  # Cache visited pages during the same session
  Turbolinks.enableTransitionCache() if RAILS_ENV == 'production'

  # Enable the progress bar
  #Turbolinks.ProgressBar.enable();

  # Live preview of Markdown text into HTML
  $('.input.preview').livePreview()

  # Show the loading image when pages are in transition
  $(document)
    .on 'page:fetch', ->
      $('.loading').fadeIn FADE_SPEED
    .on 'page:update', ->
      analytics.page(location.pathname) if analytics?
    .on 'page:load', ->
      $('.loading').fadeOut FADE_SPEED

  # Active classes for nav links
  $('#links a').on 'click', ->
    $('#links li').removeClass('active')
    $(this).closest('li').addClass('active')

  # Fetch the WAX GPL asynchronously from public/license.txt
  if $('#license').length
    $.get '/license.txt', (response) -> $('#license').text(response)
