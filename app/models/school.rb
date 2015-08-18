class School < ActiveRecord::Base
  validates_uniqueness_of :param
  
	has_many :users, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :badges

  #TODO: definition of active ? Admin AND peer logged in in last 2 weeks?
  scope :active, ->(num=10){ all }

  delegate :mentors, :peers, :non_peers, :to=>:users

  def default_badges_for_new_users; badges.tagged_with("s:default") end
end
