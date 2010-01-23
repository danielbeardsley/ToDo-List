class Item < ActiveRecord::Base
  belongs_to :list
  
  validates_presence_of :title, :list_id

  attr_protected :completed, :completed_date, :last_seen

  named_scope :uncompleted, :conditions => {:completed => false}
  named_scope :completed, :conditions => {:completed => true}

  def complete
    self.completed = true
    self.date_completed = Time.now
    save
  end
end
