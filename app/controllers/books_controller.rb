class BooksController < ApplicationController
    before_action :findbook, only: [:edit,:show,:destroy,:update]
    before_action :authenticate_user!, only: [:new, :edit]


    def new
        @b= current_user.books.build
        @c= Category.all.map{ |c| [c.name, c.id] }
    end
    
    def index   
        if params[:category].blank?
            @b=Book.all.order("created_at DESC")           
        else
            @cid=Category.find_by(name: params[:category]).id
            @b=Book.where(:category_id => @cid).order("created_at DESC")
        end
        
    end
  

    def create
        @b=current_user.books.build(bookparams)
        @b.category_id=params[:category_id]
        if @b.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit 
        @c= Category.all.map{ |c| [c.name, c.id] }
    end

    def update
        @b.category_id=params[:category_id]
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
        if @b.reviews.blank?
            @avg=0
        else
            @avg= @b.reviews.average(:rating).round(2)
        end
    end


    private
    def bookparams
        params.require(:book).permit(:title,:description,:author,:category_id,:book_img)
    end

    def findbook
        @b=Book.find(params[:id])
    end
    
end
