# Release javascript actions
jQuery ->
  $(document).on 'click', '#track-fields .remove', (event) ->
    event.preventDefault()
    $(this).closest('.release_tracks__destroy').find('input').val('1')
    $(this).closest('.fields').hide()
