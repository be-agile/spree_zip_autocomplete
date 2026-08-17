import { Controller } from "@hotwired/stimulus"
import debounce from "spree/core/helpers/debounce"
import { get } from "@rails/request.js"

async function fetchAddressByZipcode(zipcode, apiUrl) {
  let data = {}
  if (!apiUrl) {
    console.error("API URL is not defined.")
    return data
  }

  if (!zipcode) return data

  const path = `${apiUrl}?zipcode=${zipcode}`
  const response = await get(path, {
    contentType: "application/json",
  })
  if (response.ok) {
    data = await response.json
  }
  return data
}

export default class extends Controller {
  static values = {
    apiUrl: String,
  }

  static targets = [
    "address1",
    "address2",
    "zipcode",
    "city",
    "state",
    "country",
  ]

  connect() {
    this.debouncedZipcodeProcessor = debounce(this.zipcodeChanged.bind(this))
  }

  disconnect() {}

  zipcodeChanged() {
    const zipcode = this.zipcodeTarget.value.trim()

    fetchAddressByZipcode(zipcode, this.apiUrlValue)
      .then(this.fillAddressFields.bind(this))
      .catch((error) => {
        console.error("Error fetching address data:", error)
      })
  }

  fillAddressFields(data) {
    if (Object.keys(data).length === 0) {
      return
    }

    this.cityTarget.value = data.city
    this.stateTarget.value = data.state_id
    this.countryTarget.value = data.country_id
    this.address1Target.value = data.town
    this.address2Target.value = null
  }
}
