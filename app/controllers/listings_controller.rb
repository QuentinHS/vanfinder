class ListingsController < ApplicationController
  # Set listing for required methods
  before_action :set_listing, only: %i[ show edit update destroy ]
  # This throws an exception if the user is not authenticated
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_amenities, only: %i[ new edit create ]
  
  # add search function for listings, searching by both listing and van attributes 
  def search

    case params[:type]
      # Search by listing city
    when "city"
        @listings = Listing.where(["city LIKE ?", "%#{params[:query]}%"])     
      # search by listing state 
    when "state"
        @listings = Listing.where(["state LIKE ?", "%#{params[:query]}%"])
      # search by van make 
    when "make"
         @listings = []
         vans = Van.where(["make LIKE ?", "%#{params[:query]}%"])
         vans.each do |van|
            @listings << van.listing
         end
      # search by van model
     when "model"
         @listings = []
         vans = Van.where(["model LIKE ?", "%#{params[:query]}%"])
         vans.each do |van|
            @listings << van.listing
         end
      # search by van vehicle type
     when "vehicle type"
         @listings = []
         vans = Van.where(["vehicle_type LIKE ?", "%#{params[:query]}%"])
         vans.each do |van|
            @listings << van.listing
         end
    end
    # render index with searched results
    render "index"
  
  end


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
    @listing.build_van.amenity_vans.build.build_amenity

    
  
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.build(listing_params)


    respond_to do |format|
      if @listing.save
        # give creator role to listing creator
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


    # Set listing for required methods
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through. Includes additional parameters for nested forms for Listings, Van and Amenities.
    # def listing_params

    def listing_params
      params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:make, :model, :year, :odometer, :fuel_type, :listing_id, :vehicle_type, :roof_type, :sleeps,  :seats, amenity_ids: [], amenities_vans_attributes: [ :van_id, :user_id, amenity_attributes: [:name] ]])
      
    end

    # set amenities for required methods
    def set_amenities
      @amenities = Amenity.order(:name)
    end


end
