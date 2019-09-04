class ReviewsController < ApplicationController
    before_action :findbook

    def new
        @r=Review.new
    end

    def create
        @r=Review.new(paramsf)
        @r.book_id=@b.id
        @r.user_id=current_user.id
        if @r.save
            redirect_to book_path(@r)
        else
            render 'new'
        end
    end

    def edit
        
    end


    def update
        
    end

    def index     
    end

    private
    def findbook
        @b=Book.find(params[:book_id])
    end

    def paramsf
        params.find(:review).permit(:rating,:comment)
    end
end
