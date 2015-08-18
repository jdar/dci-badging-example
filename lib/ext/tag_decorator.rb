# encoding: utf-8
::ActsAsTaggableOn::Tag.class_eval do
  scope :namespaced, ->{where('name LIKE (?)','%s:%')}
  scope :non_namespaced, ->{where('name not LIKE (?)','%s:%')}
end
