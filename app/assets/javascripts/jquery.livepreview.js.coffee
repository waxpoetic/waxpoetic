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
