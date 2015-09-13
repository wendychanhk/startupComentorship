class ApplicationController < ActionController::Base

	
	before_action :configure_permitted_parameters, if: :devise_controller?
	unless Rails.env.development?
		protect_from_forgery with: :exception
	end
	

	protected
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up)<< [:email, :password, :first_name, :last_name, :country_code, :city, :company, :position, :intro, :screen_name, :avatar, {:skill => []}, {:need => []}]
		devise_parameter_sanitizer.for(:account_update)<< [:email, :password, :first_name, :last_name, :country_code, :city, :company, :position, :screen_name, :intro, :avatar, {:skill => []}, {:need => []}]
	end


end
