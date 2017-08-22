class Api::V1::BooksController < Api::V1::ApiBaseController
  before_action :authenticate_user
  before_action :set_book, only: :update

  def index
    @books = Book.all.page(params[:page])
    render json: @books, each_serializer: BookSerializer
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :price, :purchase_date, :image_data)
    end
end
