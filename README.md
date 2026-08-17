# SpreeZipAutocomplete

`spree_zip_autocomplete` is an extension for Spree that provides an API to search for addresses by zipcode. It also enables automatic form filling for `Spree::Address` forms based on the input `zipcode`.

## Installation

Add the gem to your Spree Gemfile:

```ruby
# Gemfile
gem 'spree_zip_autocomplete', path: 'engines/spree_zip_autocomplete'
```

Run the following commands:

```sh
bundle install
rails g spree_zip_autocomplete:install
```

## API

### Search for Address by Zipcode

#### Endpoint:

```
GET /api/v2/zip_autocomplete/search?zipcode={zipcode}
```

#### Notes:
- The `zipcode` parameter can be in the format `1510051` or `151-0051`.
- This API only supports addresses in **Japan**.

#### Request:

```sh
curl -X GET "http://yourstore.com/api/v2/zip_autocomplete/search?zipcode=1510051" \
     -H "Content-Type: application/json"
```

#### Response:

```json
{
  "zipcode": "1510051",
  "prefecture": "東京都",
  "city": "渋谷区",
  "town": "千駄ヶ谷",
  "state_id": 1214,
  "country_id": 347
}
```

## License

This extension is available as open source under the terms of either:
* [GNU Affero General Public License v3.0 or later (AGPL-3.0-or-later)](https://www.gnu.org/licenses/agpl-3.0.en.html)
* [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause)

## Credits

Originally created by Vinsol.
Fork maintained by [be agile Co., Ltd.](https://be-agile.jp/).%
