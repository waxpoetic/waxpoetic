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
      pathname = location.pathname.split('/')[1]
      title = $('title').text().replace('Wax Poetic Records', '').replace(' | ', '') || 'Home'
      category = if pathname == 'artists' || pathname == 'releases' || pathname == 'store'
        pathname
      else
        'page'
      name = if title.toLowerCase() == category
        "#{title} Index"
      else
        title

      if analytics?
        analytics.page(category, title)
      else
        console.log("Page view recorded for '#{title}' (category: #{category})")
    .on 'page:load', ->
      $('.loading').fadeOut FADE_SPEED

  # Active classes for nav links
  $('#links a').on 'click', ->
    $('#links li').removeClass('active')
    $(this).closest('li').addClass('active')

  # Fetch the WAX GPL asynchronously from public/license.txt
  if $('#license').length
    $.get '/license.txt', (response) -> $('#license').text(response)
