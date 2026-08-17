import { lazyLoadControllersFromManifest } from "spree/storefront/helpers/lazy_load_controllers_with_manifest"

const controllers = ["zip-autocomplete"]
const manifest = {
  "zip-autocomplete":
    "spree_zip_autocomplete/storefront/controllers/zip_autocomplete_controller",
}

const application = window.Stimulus
const apiUrl = "/api/v2/zip_autocomplete/search"

function setAttribute(element, name, value) {
  if (!!element) {
    element.setAttribute(name, value)
  }
}

function setupZipAutocomplete() {
  // giga は Spree 5.3 コアの Google Places 補完(address-autocomplete)を住所フォームから外し、
  // 独自の address-form コントローラに置き換えている(app/views/spree/addresses/_form.html.erb)。
  // そのため address-autocomplete ではなく address-form を持つ div.inner を対象にする。
  // form の id では絞らない: デジタル商品など配送不要の注文では住所フォームが address ステップではなく
  // payment ステップ(form#checkout_form_payment, bill_address)に出るため、form[id*="address"] では
  // 取りこぼす。div.inner[data-controller~="address-form"] は giga の住所フォーム専用なので一意に特定できる。
  // @see https://github.com/be-agile/giga-repeat/issues/1210
  const formAddresses = document.querySelectorAll(
    'div.inner[data-controller*="address-form"]:not([data-controller*="zip-autocomplete"])'
  )
  formAddresses.forEach((formAddress) => {
    // standalone(address_*) / 配送先(order_ship_address_*) / 請求先(order_bill_address_*) の
    // いずれの命名でも拾えるよう、id ではなく name の末尾で照合する。
    const inputs = {
      address1: formAddress.querySelector('input#address_address1, input[name$="[address1]"]'),
      address2: formAddress.querySelector('input#address_address2, input[name$="[address2]"]'),
      zipcode: formAddress.querySelector('input#address_zipcode, input[name$="[zipcode]"]'),
      city: formAddress.querySelector('input#address_city, input[name$="[city]"]'),
      state: formAddress.querySelector('select#address_state_id, select[name$="[state_id]"]'),
      country: formAddress.querySelector('select#address_country_id, select[name$="[country_id]"]'),
    }
    setAttribute(formAddress, "data-controller", `${formAddress?.dataset?.controller || ''} zip-autocomplete`)
    setAttribute(formAddress, "data-zip-autocomplete-api-url-value", apiUrl)

    setAttribute(inputs.zipcode, "data-zip-autocomplete-target", "zipcode")
    setAttribute(inputs.zipcode, "data-action", `${inputs?.zipcode?.dataset?.action || ''} input->zip-autocomplete#debouncedZipcodeProcessor`)

    setAttribute(inputs.address1, "data-zip-autocomplete-target", "address1")
    setAttribute(inputs.address2, "data-zip-autocomplete-target", "address2")
    setAttribute(inputs.city, "data-zip-autocomplete-target", "city")
    setAttribute(inputs.state, "data-zip-autocomplete-target", "state")
    setAttribute(inputs.country, "data-zip-autocomplete-target", "country")
  })
  lazyLoadControllersFromManifest(controllers, null, application, manifest)
}

document.addEventListener("turbo:load", setupZipAutocomplete)
document.addEventListener("turbo:frame-render", setupZipAutocomplete)
document.addEventListener("turbo:before-stream-render", (event) => {
  const originalRender = event.detail.render
  event.detail.render = function (streamElement) {
    originalRender(streamElement)
    setupZipAutocomplete()
  }
})
