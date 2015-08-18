class FollowController < ApplicationController
  include ApplicationHelper
  extend Surrounded
  before_action :authenticate_user! 

  def index
    @peers ||= PredictPeersToReward.new(current_user,location,Time.now).predict(params[:count])
    @badges ||= current_school.badges
    @recognizeable_badges = RecognizePeersContext.new(current_user, @badges, @peers)
      .badges_that_can_be_recognized_for_any 
  end

  def scoped
    #TODO: better prediction, via params
    @peers = current_school.peers.where(params[:scope][:users]).all if params[:scope][:users]
    @badges = current_school.peers.where(params[:scope][:badges]).all if params[:scope][:badges]
    @scope = params[:scope] || {}
    index
    render :index
    return
  end
private

  def location
    #TODO: guess based on request information / beacon ?
    current_school.locations.first  
  end
end
