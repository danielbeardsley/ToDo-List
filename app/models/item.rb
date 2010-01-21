class Item < ActiveRecord::Base
  def self.allowed_types
    %w{Fun Work Task}
  end

  validates_inclusion_of :type, :in => allowed_types
  validates_presence_of :title

end
