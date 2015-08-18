#TODO: deprecated: InheritedResources. Use 'respond_with'
class UsersController < InheritedResources::Base
  before_action :authenticate_user! 
end
