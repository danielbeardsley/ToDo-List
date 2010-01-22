require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  should_not_allow_mass_assignment_of :completed, :completed_date, :last_seen

  should_have_named_scope :uncompleted, :conditions => {:completed => false}
  should_have_named_scope :completed, :conditions => {:completed => true}

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
