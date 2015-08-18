class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include Surrounded 

  validates :first_name, :last_name, :account, presence: true

  belongs_to :school

  scope :thoughtleader, -> { where(role: 'thoughtleader') } 
  
  has_many :recognitions
  has_many :badges, :through => :recognitions
  
  # This assumes we don't want recipriocal; 
  # TODO: double-adding possible. 2 browser problem.
  has_many :followings
  has_many :peers, :through => :followings
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "peer_id"
  has_many :inverse_peers, :through => :inverse_followings, :source => :user 

  after_initialize :default_attributes
  before_save :finalize_attributes

  def full_name
    "#{first_name} #{last_name}"
  end

  def can_edit_badge_tags?(badge)
    role == 'thoughtleader'
  end
  def can_edit_badge?(badge)
    role == 'thoughtleader'
  end

  private

  def default_attributes
    self.account ||= 100
  end
  def finalize_attributes
    if self.badges.empty?
      self.badges = school.default_badges_for_new_users
    end
  end

end
