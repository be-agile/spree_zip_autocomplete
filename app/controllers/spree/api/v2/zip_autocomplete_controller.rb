require "jipcode"

module Spree
  module Api
    module V2
      class ZipAutocompleteController < Spree::Api::V2::BaseController
        before_action :validate_zipcode

        def search
          render json: fetch_address(params[:zipcode])
        end

        private

        def validate_zipcode
          return if params[:zipcode].present?

          render json: {}
        end

        def fetch_address(zipcode)
          address = Jipcode.locate(zipcode.to_s.gsub(/-/, "")).first
          return {} if address.blank?

          state = Spree::State.find_by(name: address[:prefecture])
          country = Spree::Country.find_by(iso: "JP")
          address.merge(state_id: state.try(:id), country_id: country.try(:id))
        end
      end
    end
  end
end
