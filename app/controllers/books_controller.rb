class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @userr = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @userr = current_user
  end

  def show
    @book_detail = Book.find(params[:id])
    @userr = User.find(@book_detail.user.id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to  books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @userr = @book.user
    redirect_to(books_path) unless @userr == current_user
  end

end
