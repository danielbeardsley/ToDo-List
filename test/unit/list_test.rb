require 'test_helper'

class ListTest < ActiveSupport::TestCase
  should_have_many :items
  should_belong_to :current_item

  context "A List with several items" do
    setup do
      @list = List.create(:name => 'List1')
      @items = (1..3).to_a.map do |i|
        @list.items.create(:title => "Item #{i}")
      end
    end

    should "set current_item to one of it's items" do
      assert_nil @list.current_item

      @list.choose_next_item
      assert_contains @items, @list.current_item

      assert @list.current_item.last_seen > 5.seconds.ago
    end

    should "set current_item when get_current_item is first called" do
      assert_nil @list.current_item

      item = @list.get_current_item
      assert_equal item, @list.current_item
      assert_contains @items, @list.current_item
    end

    should "return an appropriate item to do" do
      assert_contains @items, @list.items.next
    end
  end
end
