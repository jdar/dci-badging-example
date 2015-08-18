class Badge < ActiveRecord::Base
  SPECIFICATION_ATTRS = [:name, :description, :image, :tags]

  belongs_to :school
  acts_as_taggable 
  
  has_many :recognitions
  has_many :users, through: :recognitions

  scope :active, ->(num=10){ all }

  #'title' in the html usage of the word
  def title; [name,description].compact.join(": ").to_s end
  def has_points?; points && points > 0 end
  

  #TODO: what is the right way to create cache?
  @@categories = {}
  def self.category_label(badge)
    @@categories || all.group_by{|b|
      if b.has_points?
        "Points"
      elsif b.tag_list.include?("s:achievement")
        "Achievement"
      else
        "Other"
      end
    }
    @@categories[badge]
  end    
  def category_label; self.class.category_label(self) end
end
