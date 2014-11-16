# A helper for Turbolinks. Set this on kind of loading element and watch
# it appear/disappear when the page is loading.
$.fn.turboload = (options) ->
  @each(i, element) ->
    img = $(element)
    $(document)
      .on 'page:fetch', -> img.fadeIn options.fadeSpeed
      .on 'page:load',  -> img.fadeOut options.fadeSpeed
