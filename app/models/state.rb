class State < ActiveRecord::Base
  validates :name, :presence => true

  has_many :tickets

  def to_s
    name
  end
end
