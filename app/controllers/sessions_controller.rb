class SessionsController < ApplicationController
  def omniauth
    @user = User.from_omniauth(auth)

    if User::EMAILS.include? @user.email 
      @user.save
      session[:email] = @user.email
      redirect_to articles_path
    else
      #https://oauth2.googleapis.com/revoke
      #https://accounts.google.com/o/oauth2
      uri = URI('https://accounts.google.com/o/oauth2/revoke')
      params = { :token => auth.credentials.token }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
      flash[:errors] = "User not allowed to access the website. Please contact your administrator for this."
      redirect_to root_path
    end 
  end

  # DELETE /logout
  def destroy
    # Remove value of session[:email] and redirect to homepage
  	session[:email] = nil
  	redirect_to root_path
  end

  private
    def auth
      request.env['omniauth.auth']
    end
end
