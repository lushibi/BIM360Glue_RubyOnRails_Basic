class SessionsController < ApplicationController
  def new
  end

  def create
    login_name = params[:session][:login_name]
    password = params[:session][:password].to_s
    response = glue_login login_name, password

    puts "[Login Response] [#{response.code}] #{response.message}: #{response.body}"

    if response.code == '200'
      result = JSON.parse(response.body)
      save_session login_name, result["auth_token"]
      redirect_to root_path
    else
      flash.now[:danger] = "[#{response.code}] #{response.message}: #{response.body}"
      render 'new'
    end
  end

  def destroy
    delete_session
    redirect_to login_path
  end
end
