FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_paypal_braintree/factories'
end

FactoryBot.modify do
  # The Solidus address factory randomizes the zipcode.
  # The OrderWalkThrough we use in the credit card checkout spec uses this factory for the user addresses.
  # For credit card payments we transmit the billing address to braintree, for paypal payments the shipping address.
  # As we match the body in our VCR settings VCR can not match the request anymore and therefore cannot replay existing cassettes.
  #
  factory :address do
    zipcode '21088-0255'
    lastname "Doe"
  end

  factory :shipping_method, aliases: [:base_shipping_method], class: 'Spree::ShippingMethod' do
    zones do
      [Spree::Zone.find_by(name: 'GlobalZone') || FactoryBot.create(:global_zone)]
    end

    name 'UPS Ground'
    code 'UPS_GROUND'
    # carrier 'UPS'
    # service_level '1DAYGROUND'

    calculator { |s| s.association(:shipping_calculator, strategy: :build, preferred_amount: s.cost, preferred_currency: s.currency) }

    transient do
      cost 10.0
      currency { Spree::Config[:currency] }
    end

    before(:create) do |shipping_method, _evaluator|
      if shipping_method.shipping_categories.empty?
        shipping_method.shipping_categories << (Spree::ShippingCategory.first || create(:shipping_category))
      end
    end
  end

  factory :order, class: 'Spree::Order' do
    user
    bill_address
    ship_address
    completed_at nil
    email { user.try(:email) }
    store

    transient do
      line_items_price BigDecimal.new(10)
    end
  end
end
