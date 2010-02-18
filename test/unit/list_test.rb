require 'test_helper'

class ListTest < ActiveSupport::TestCase
  should_have_many :items
  should_belong_to :current_item

  should_not_allow_mass_assignment_of :current_item_id

  context "A List with several items" do
    setup do
      @list = List.create(:name => 'List1')
      @items = (1..3).to_a.map do |i|
        @list.items.create(:title => "Item #{i}")
      end
    end

    should "have no current_item" do
      assert_nil @list.current_item
    end

    should "set current_item to one of it's items" do
      @list.choose_next_item
      assert_contains @items, @list.current_item

      assert @list.current_item.last_seen > 5.seconds.ago
    end

    should "set current_item when get_current_item is first called" do
      item = @list.get_current_item
      assert_equal item, @list.current_item
      assert_contains @items, @list.current_item
    end

    should "return an appropriate item to do" do
      assert_contains @items, @list.items.next

      @list.items.each(&:complete)
      assert_nil @list.items.next
    end

    context "and the current item is completed" do
      setup do
        @current_id = @list.get_current_item.id
        @list.complete_current_item
        @list.reload
      end

      should "mark current_item as completed" do
        item = Item.find(@current_id)
        assert item.completed
        assert item.date_completed > 5.seconds.ago
      end

      should "set current_item to null" do
        assert_nil @list.current_item
      end
    end

    context "and the current item is deferred" do
      setup do
        @current_id = @list.get_current_item.id
        @list.defer_current_item
        @list.reload
      end

      should "not mark current_item as completed" do
        item = Item.find(@current_id)
        assert !item.completed
      end

      should "set current_item to nil" do
        assert_nil @list.current_item
      end
    end
  end
end
