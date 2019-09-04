class ReviewsController < ApplicationController
    before_action :findbook
    before_action :findreview ,only: [:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def new
        @r=Review.new
    end

    def create
        @r=Review.new(paramsf)
        @r.book_id=@b.id
        @r.user_id=current_user.id
        if @r.save
            redirect_to book_path(@b)
        else
            render 'new'
        end
    end

    def edit
        
    end


    def update
        if @r.update(paramsf)
            redirect_to book_path(@b)
        else
            render 'edit'
        end
    end

    def destroy
        @r.destroy
        redirect_to book_path(@b)    
    end

    private
    def findbook
        @b=Book.find(params[:book_id])
    end 

    def paramsf
        params.require(:review).permit(:rating,:comment)
    end

    def findreview
        @r=Review.find(params[:id])
    end
end
