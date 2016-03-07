class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivu

  end

  def create_oauth
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  def create
    # haetaan usernamea vastaava käyttäjä tietokannasta
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password]) && user.active==true
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    elsif not user.authenticate(params[:password])
      redirect_to :back, notice: "Username and/or password mismatch"
    elsif user.active==false
       redirect_to :back, notice: "Account is Frozen, please contact admin"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end