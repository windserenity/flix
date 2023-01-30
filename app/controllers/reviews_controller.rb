class ReviewsController < ApplicationController
  before_action :require_signin, except: :index
  before_action :require_current_user, only: [:edit, :update, :destroy]

  before_action :set_movie

  def index
    @reviews = @movie.reviews
    
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_reviews_path(@movie), notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = @movie.reviews.find(params[:id])
  end

  def update
    @review = @movie.reviews.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "Review updated successfully!"
      redirect_to movie_reviews_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = @movie.reviews.find(params[:id])
    @review.destroy
    unless @movie.has_review?
      redirect_to @movie, status: :see_other
      flash[:alert] = "Review deleted successfully!"
    else
      redirect_to movie_reviews_url, status: :see_other
      flash[:alert] = "Review deleted successfully!"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :stars)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def require_current_user
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
    @user = @review.user
    unless current_user?(@user)
      redirect_to root_url, status: :see_other
    end
  end
end
