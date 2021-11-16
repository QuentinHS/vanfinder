class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  # This throws an exception if the user is not authenticated
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_amenities, only: %i[ new edit create ]
  before_action :set_vans, only: %i[ new edit create ]
  before_action :set_amenity_vans, only: %i[ new edit create ]
  before_action :process_amenity_vans_attrs, only: [:create, :update]

  # GET /listings or /listings.json
  def index
    @listings = Listing.order(created_at: :desc)
  end

  # GET /listings/1 or /listings/1.json
  def show
    # Pundit authorisation for show view
     authorize @listing
  end

  # GET /listings/new
  def new
    
    @listing = Listing.new
    @listing.build_van.amenity_vans.build

    # @amenities.each do |amenity|
    #   @listing.van.amenity_vans.build(amenity_id: amenity_id)
    # end
    
  
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.build(listing_params)

    respond_to do |format|
      if @listing.save
        current_user.add_role :creator, @listing     
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through. Includes parameters for nested forms for Listings, Van and Amenities.
    # def listing_params

    # params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:make, :model, :year, :odometer, :fuel_type, :listing_id, :type, :roof_type, :sleeps, :seats, amenity_ids: [], amenities_attributes: [:id, :name, :_destroy ]] )
    # end


    def listing_params
      params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:make, :model, :year, :odometer, :fuel_type, :listing_id, :type, :roof_type, :sleeps, :seats ] )
    end

    def set_amenities
      @amenities = Amenity.order(:name)
    end

    def set_vans
      @vans = Van.all
    end

    def set_amenity_vans
      @amenity_vans = AmenityVan.all
    end

  def process_amenity_vans_attrs
    params[:listing][:van_attributes][:amenities_vans_attributes].values.each do |amen_attr|
      amen_attr[:_destroy] = true if amen_attr[:enable] != '1'
    end
  end


end
