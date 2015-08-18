class RecognitionsController < ApplicationController
  include ApplicationHelper
  def create
    badge_ids = params[:recognitions] ? params[:recognitions][:badge_ids] : params[:recognition][:badge_id]
    user_ids  = params[:recognitions] ? params[:recognitions][:user_ids] : params[:recognition][:user_id]

    badges = current_school.badges.where(id: badge_ids)
    users  = current_school.users.where(id: user_ids)

    #QUESTION: different context selected here, by role, using if-statement???

    RecognizePeersContext.new(current_user,badges,users).recognize_all

    previous_count = cookies[:recognitions].to_i

    #TODO: in fact, some users may already have had some of these badges
    # so this "new_count" number may be higher than the real number.
    # would need to be solved with return value, or pre-calculation of recognizaability
    new_count = previous_count+(users.length * badges.length)
    cookies[:recognitions] = { :value => new_count, :expires => Time.now + (5*60)} 
     
    return_to_path = params[:return_to] || follow_path
    redirect_to return_to_path, flash: {notice: "Approximately #{new_count} badges awarded in the last 5 minutes (achievement badges may be overcounted.)"}
  end 

  def destroy
    raise "NYI"
  end
end
