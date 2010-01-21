class Item < ActiveRecord::Base

  #the default for this is 'type' which conflicts with our type column
  set_inheritance_column :inheritance_type

  def self.allowed_types
    %w{Fun Work Task}
  end

  validates_inclusion_of :type, :in => allowed_types
  validates_presence_of :title

  attr_protected :completed, :completed_date

  def done_it
    self.completed = true
    self.date_completed = Time.now
    save
  end
end
