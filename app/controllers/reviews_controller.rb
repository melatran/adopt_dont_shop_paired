class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.new(review_params)
    if review.save
      flash[:notice] = "Review successfully created!"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Review not created: please fill out all indicated fields"
      redirect_to "/shelters/#{shelter.id}/new_review"
    end
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])

    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter.id}"
    # code
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.find(params[:review_id])
    if review.update(review_params)
      flash[:notice] = "You have successfully updated your review"
      redirect_to "/shelters/#{review.shelter_id}"
    else
      redirect_to "/shelters/#{review.shelter_id}/#{review.id}/edit"
      flash[:notice] = "Updates haven't been made. Fill in all blanks"
    end
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
