class DetailsController < ApplicationController

  before_action :set_details, only: [:show, :update, :destroy]

  # GET /details
  def index
    error = false
    @details = Detail.all
    @details = @details.building_type(params[:building_type]) if params[:building_type].present?
    if params[:beds_range].present?
      unless params[:beds_range] =~ /^\d+-?\d*$/
        error = true
        @details = ["Please check beds range search value passed."]
      else
        beds_range = params[:beds_range].try(:split, '-')
        if beds_range.count == 2
          beds_min, beds_max = beds_range.map{|x| x.to_i}.sort 
          @details = @details.beds_range(beds_min, beds_max)
        elsif beds_range.count == 1
          @details = @details.where(beds: beds_range.try(:first).try(:to_i))
        end
      end
    end
    if params[:sq__ft_range].present?
      unless params[:sq__ft_range] =~ /^\d+-?\d*$/
        if error == true
          @details = ["Please check beds & sq__ft range search value passed."]
        else
          error = true
          @details = ["Please check sq__ft range search value passed."]
        end
      else
        if error == false
          sq__ft_range = params[:sq__ft_range].try(:split, '-')
          if sq__ft_range.count == 2
            sq__ft_min, sq__ft_max = sq__ft_range.map{|x| x.to_i}.sort 
            @details = @details.sq__ft_range(sq__ft_min, sq__ft_max)
          elsif sq__ft_range.count == 1 
            @details = @details.where(sq__ft: sq__ft_range.try(:first).try(:to_i))
          end
        end
      end
    end
    @details = @details.paginate(:page => params[:page], :per_page => 10) unless error == true
    json_response(@details)
  end

  # POST /details
  def create
    @detail = Detail.create!(details_params)
    json_response(@detail, :created)
  end

  # GET /details/:id
  def show
    json_response(@detail)
  end

  # PUT /details/:id
  def update
    @detail.update(details_params)
    head :no_content
  end

  # DELETE /details/:id
  def destroy
    @detail.destroy
    head :no_content
  end

  private

  def details_params
    params.permit(:street, :city, :zip, :state, :beds, :baths, :sq__ft, :building_type, :sale_date, :price, :latitude, :longitude)
  end

  def set_details
    @detail = Detail.find(params[:id])
  end
end
