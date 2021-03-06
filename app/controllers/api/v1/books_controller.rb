class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.search book_search_params
    paginate @books
  end

  # GET /books/:id
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: api_v1_book_url(@book)
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    @book.destroy
  end

  private
    def set_book
      @book = Book.find params[:id]
    end

    def book_search_params
      params.permit :title, :isbn
    end

    def book_params
      params
        .require(:book)
        .permit(:title, :author, :isbn, :price, :short_description)
    end
end
