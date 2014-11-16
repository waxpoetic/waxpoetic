# Undo or destroy row in nested attribute forms.
$.fn.undo = ->
  $(document).on 'click', $(this).selector, (event) ->
    event.preventDefault()
    $(this).closest('.release_tracks__destroy').find('input').val('1')
    $(this).closest('.fields').hide()
