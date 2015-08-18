class BadgesController < InheritedResources::Base
  include ApplicationHelper
  before_action :authenticate_user!, except: [:show, :openbadge]
  respond_to :json
  def index  
    @can_edit_any_badge = current_school.badges.any?{|b| current_user.can_edit_badge?(b) }
    super
  end

  def show
    @badge = Badge.find(params[:id])
    @tags = @badge.tags.non_namespaced
    super
  end
  alias openbadge show

  private
  def badge_params
    params.require(:badge).permit(:name, :description, :points, :tag_list)
  end
end

