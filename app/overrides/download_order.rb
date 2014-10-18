
# Allows the user to download the item they are attempting to 

Deface::Override.new \
          name: 'download_order',
  virtual_path: 'spree/checkout/summary',
  insert_after: 'tr[data-hook="item_total"]',
       partial: 'spree/checkout/summary/download'
