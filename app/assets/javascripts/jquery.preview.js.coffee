#
# jQuery Live Preview v0.0.1
#
# Requires: marked
#
# Renders a live preview of whatever Markdown code it is given into the
# '.rendered-html' element within the row. Attach it to a <div> that
# wraps your <textarea> element for best results.

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
