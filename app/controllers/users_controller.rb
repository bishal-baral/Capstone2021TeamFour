class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
            reset_session
            log_in @user
            flash[:sucess] = "Caught you on the flippity flip"
            redirect_to @user
        else
            render 'new'
        end

    end

    def show
        @user = User.find(params[:id])
    end

    private

        def user_params
            params.require(:user).permit(:email, :username, :password,
                                                    :password_confirmation)
        end

end
