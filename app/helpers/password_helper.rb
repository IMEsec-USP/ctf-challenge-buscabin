module PasswordHelper
  def create
    session[:tries_left] = 20
    session[:password] = generate_random_number
  end

  def decrement
    session[:tries_left] -= 1
  end

  def ran_out
    session[:tries_left] <= 0
  end

  def create_if_not_exists
    if session[:tries_left] == nil
      create
    end
  end

  def reset
    create
  end

  def generate_random_number
    rand(100000)
  end
end