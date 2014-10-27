# Release javascript actions
jQuery ->
  $(document).on 'click', '#track-fields .remove', (event) ->
    event.preventDefault()
    $(this).closest('.release_tracks__destroy').find('input').val('1')
    $(this).closest('.fields').hide()

  $('input[name="variant_id"]').on 'change', (event) ->
    selectedVariant = $('input[name="variant_id"]:selected')
    price = selectedVariant.attr('data-price')
    $('#buy-button').html("Buy Release (#{price})")
    $('#add-to-cart').html("Add to Cart for #{price}")

  $('#add-to-cart').on 'click', (event) ->
    event.preventDefault()
    selectedVariant = $('input[name="variant_id"]:selected')
    $.ajax \
      url: '/store/api/orders',
      method: 'POST',
      dataType: 'json',
      data: {
        line_items: [{
          variant_id: selectedVariant.val()
          quantity: 1
        }]
      }
      success: ->
        $('#buy-button')
          .html('Added to Cart!')
          .removeClass('success')
          .addClass('secondary')
      error: (message) ->
        alert message
