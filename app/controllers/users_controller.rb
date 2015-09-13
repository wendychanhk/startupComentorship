
require 'eventbrite'

class UsersController < ApplicationController
	before_action :authenticate_user!

 #  named_scope :without_user, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }
  # GET /users
  def index

    Eventbrite.token = 'GW7F56RPWBEZOKIZ4KO6'
    @events = Eventbrite::Event.search({:"venue.city" => current_user.city, :"venue.country" => current_user.country_code, q: (current_user.need).join(", OR ")})

    @conversations = Conversation.involving(current_user).order("created_at DESC")

    #Let's load all the users that make a match
    #current_user.find_users_matches 

  #if params[:search].present?
  #  users_all_searched = User.search(params[:search])
   #users_matched =  (current_user.find_users_matches_need | current_user.find_users_matches_skill)  
  # @users = users_all_searched && users_matched
  #else
  
  @users = current_user.find_users_matches_need | current_user.find_users_matches_skill

 # end
end

  # GET /users/1
  def show
    @users = User.all

  end

  # GET /users/new
  def new
    @user = User.new

    @all_skills = Skill.all? 
    @users_skills = @user.users_have_skills.build

  end

  # GET /users/1/edit
  def edit
    @user = current_user
    
  end

  def profile
    @user = current_user
    render 'users/profile'
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = current_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end



  private
  
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :country_code, :city, :company, :position, :intro, :avatar, :screen_name, {:skill => []}, {:need => []})


  end
end






