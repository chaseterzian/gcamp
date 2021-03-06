class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def authenticate_user
    if current_user.present?
    else
      session[:piss_off] ||= request.fullpath
      flash[:warning] = "You must sign in"
      redirect_to signin_path
    end
  end

  def current_user
    if session[:user_id].present?
      User.find_by(id: session[:user_id])
    end
  end

  def ensure_admin_owner_or_self
    if !(current_user.admin_owner?(@project) || current_user.id == @membership.user_id)
      flash[:warning] = 'You do not have access'
      redirect_to projects_path
    end
  end

  def authorize_user_for_project
    unless current_user.projects.include?(@project) || current_user.admin == true
      flash[:warning] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def user_role_is_owner
    current_user.admin || @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"]
    # @project.memberships.find_by(user_id: current_user.id).role == "Owner"
  end

  def owner_permission
    # if @project.memberships.where(user_id: current_user.id).include?(role: "Owner") || current_user.admin == true
    if @project.memberships.where(user_id: current_user.id).pluck(:role) == ["Owner"] || current_user.admin == true
    else
      flash[:warning] = "You do not have access"
      redirect_to project_path(@project)
    end
  end


  def set_admin
    User.find(params[:id])
  end


helper_method :current_user
helper_method :user_role_is_owner
helper_method :user_permission
helper_method :cant_update_last_owner

end


# def token_length
#   string_arr = self.split(' ')
#   string_arr.count > 5 ? "#{string_arr[0..(limit-1)].join(' ')}..." : self
# end

#current_user.memberships.map(&:project_id).include?(project.id)
#project.memberships.map(&:user_id).include?(current_user.id)

# if current_user.projects.where(id: project.id).empty?
# no dice
# unless current_user.projects.where(id: project.id).any?
# also no dice
# def authorize_user_to_delete_membership
#   if current_user.project.memberships.include?(@membership)
#     flash[:message] = "TESTING MEMBERSHIP DELETE OF SELF"
#   end
# end

#rails render 404 files

# @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]  #optimization
