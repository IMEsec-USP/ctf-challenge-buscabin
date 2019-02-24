class PasswordController < ApplicationController
  include PasswordHelper
  def show
    create_if_not_exists
    validate_has_chance
    @tries_left = session[:tries_left]
  end

  def check
    create_if_not_exists
    password = params[:password][:password].to_i
    puts session[:password]
    comparison = password <=> session[:password]
    if comparison == 0
      reset
      render 'flag'
      return
    end

    decrement
    did_ran_out = ran_out
    validate_has_chance
    if !did_ran_out
      comparison_word = comparison > 0 ? 'menor' : 'maior'
      flash.now[:warning] = "Você errou a senha. A senha é #{comparison_word} que a inserida."
    end
    @tries_left = session[:tries_left]
    render 'show'
  end

  def validate_has_chance
    if ran_out
      flash.now[:danger] = 'Você esgotou suas chances. A senha mudou.'
      reset
    end
  end
end
