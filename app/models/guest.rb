class Guest < ActiveRecord::Base

  def self.find_by_name(name)
    where(Guest.arel_table[:name].matches("%#{name}%")).first
  end
end
