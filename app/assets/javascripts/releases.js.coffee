# Release javascript actions
jQuery ->
  # Append tracks.
  $('#add-track').on 'click', (event) ->
    event.preventDefault()
    track = $('#release-track-template').clone()
    track.find('input,select,textarea').each (i, element) ->
      field = $(element)
      field.attr 'name', "#{field.attr('name')}_#{Date.today()}"
    track.addClass 'release-track'
    track.attr 'id', "release-track-#{Date.today()}"
    $('#release-tracks .list').append(track)

  # Remove tracks.
  $(document).on 'click', '.release-track .remove', (event) ->
    event.preventDefault()
    track = $(this).closest('.release-track')
    track.find('input[name="_destroy"]').value('1')
    track.hide()
