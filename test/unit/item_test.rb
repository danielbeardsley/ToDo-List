require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should "have allowed_types" do
    assert Item.respond_to?(:allowed_types)
    assert_same_elements %w{Fun Work Task}, Item.allowed_types
  end

  should_not_allow_values_for(:type, 'ldkfjs', 'something', :message => /not included/i)
  should_allow_values_for(:type, *Item.allowed_types)

  should_not_allow_mass_assignment_of :completed, :completed_date

  should_have_named_scope :uncompleted, :conditions => {:completed => false}
  should_have_named_scope :completed, :conditions => {:completed => true}

  should_have_named_scope "of_type('TTT')", {:conditions => {:type => 'TTT'}}

  context "an item marked as completed" do
    setup do
      @item = Item.create(:title => "Thing to do", :type => "Task")
      @item.complete
      @item.reload
    end

    should "be marked as completed" do
      assert @item.completed
      assert(@item.date_completed <= DateTime.now && @item.date_completed > 1.minute.ago, "date_completed should be right now")
    end
  end
end
