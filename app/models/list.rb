class List < ActiveRecord::Base
  has_many :items
  belongs_to :current_item, :class_name => 'item'
end
