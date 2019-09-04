class BooksController < ApplicationController
    before_action :findbook, only: [:edit,:show,:destroy,:update]

    def new
        @b= current_user.books.build
    end
    
    def index   
        @b=Book.all.order("created_at DESC") 
    end

    

    def create
        @b=current_user.books.build(bookparams)
        if @b.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit 
    end

    def update
        if @b.update(bookparams)
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def destroy 
        @b.destroy
            redirect_to root_path  
    end

    def show
    end


    private
    def bookparams
        params.require(:book).permit(:title,:description,:author)
    end

    def findbook
        @b=Book.find(params[:id])
    end
    
end
