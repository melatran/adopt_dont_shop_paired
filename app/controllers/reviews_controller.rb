class ReviewsController < ApplicationController

  def new
    # @shelter = Shelter.find(params[:id])
    @shelter_id = params[:shelter_id]

  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.create!(review_params)
    redirect_to "/shelters/#{shelter.id}"
  end
  # def create
  #
  #   @review = Review.new(review_params)
  #   require "pry"; binding.pry
  #   @shelter_id = @review.shelter_id
  #   # @review = Review.new(shelter_id: shelter_id[:id])
  #   # require "pry"; binding.pry
  #   if @review.save
  #     redirect_to "/shelters/#{@shelter_id}"
  #   else
  #     flash[:notice] = "Failed to enter review information: Please enter all info"
  #     redirect_to "/shelters/#{@shelter_id}/new_review"
  #   end
  # end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
    # params.require(:review).permit(:title, :rating, :content, :image)
  end
  # def shelter_id
  #   params.permit(:id)
  # end
end
