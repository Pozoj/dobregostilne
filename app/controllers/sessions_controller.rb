# Encoding: utf-8
class SessionsController < ApplicationController
  skip_before_filter :authenticate, :except => :destroy
  def create
    session[:password] = params[:password]
    
    if admin?
      redirect_to root_path
    else
      flash[:error] = "Napačno geslo."
      redirect_to new_session_path
    end
  end
  
  def destroy
    session[:password] = nil
    redirect_to root_path
  end
end