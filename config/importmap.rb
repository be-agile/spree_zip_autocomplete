pin 'spree-zip-autocomplete', to: 'spree_zip_autocomplete/storefront/index.js', preload: false

pin_all_from SpreeZipAutocomplete::Engine.root.join('app/assets/javascripts/spree_zip_autocomplete/storefront/controllers'),
             under: 'spree_zip_autocomplete/storefront/controllers',
             to: 'spree_zip_autocomplete/storefront/controllers',
             preload: false
