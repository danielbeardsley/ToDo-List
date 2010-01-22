require 'test_helper'

class ListTest < ActiveSupport::TestCase
  should_have_many :items
  should_belong_to :current_item
end
