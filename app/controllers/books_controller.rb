class BooksController < ApplicationController
  before_action :ensure_user,only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
    flash[:success] = "You have created book successfully."
    redirect_to book_path(@book.id)
   else
    @books =Book.all
    @user = current_user
    render :index
   end
  end


  def index
    @book =Book.new
    @books =Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def ensure_user
    @books = current_user.books
    @book =@books.find_by(id: params[:id])
    redirect_to books_path unless @book
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

