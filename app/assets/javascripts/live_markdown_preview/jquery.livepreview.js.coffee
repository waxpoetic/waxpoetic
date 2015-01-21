# = jQuery.livePreview
#
# When activated on a `.preview.input` div, it renders the Markdown text
# in the <textarea> directly to HTML in another frame of the page.
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
