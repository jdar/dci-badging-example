class FollowingsController < InheritedResources::Base
  def create
    @shared_class = current_user.followings.build(:peer_id => params[:peer_id])
    if @shared_class.save
      flash[:notice] = "Added peer."
      redirect_to current_user
    else
      flash[:error] = "Unable to add peer."
      redirect_to current_user
    end
  end

  def destroy
    @followings = current_user.followings.where(peer_id: params[:peer_id]).first
    @followings.destroy
    flash[:notice] = "This user will not be suggested interactively."
    redirect_to current_user
  end 
end

