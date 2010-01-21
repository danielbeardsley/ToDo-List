require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should "have allowed_types" do
    assert Item.respond_to?(:allowed_types)
    assert_same_elements %w{Fun Work Task}, Item.allowed_types
  end

  should_not_allow_values_for(:type, 'ldkfjs', 'something', :message => /not included/i)
  should_allow_values_for(:type, *Item.allowed_types)
end
