module ApplicationHelper
  def users
    current_school.users
  end
  def current_school
    return unless current_user
    @memo_current_school ||= current_user.school
  end
end
