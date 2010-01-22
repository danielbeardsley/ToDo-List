class Item < ActiveRecord::Base

  #the default for this is 'type' which conflicts with our type column
  set_inheritance_column :inheritance_type

  def self.allowed_types
    %w{Fun Work Task}
  end

  validates_inclusion_of :type, :in => allowed_types
  validates_presence_of :title

  attr_protected :completed, :completed_date

  named_scope :uncompleted, :conditions => {:completed => false}
  named_scope :completed, :conditions => {:completed => true}
  named_scope(:of_type, lambda{|type| {:conditions => {:type => type}}})

  def complete
    self.completed = true
    self.date_completed = Time.now
    save
  end
end
