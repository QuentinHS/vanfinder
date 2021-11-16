class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  # This throws an exception if the user is not authenticated
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_amenities, only: %i[ new edit create ]
  before_action :set_amenity_vans, only: %i[ new edit create ]
  before_action :set_vans, only: %i[ new edit create ]

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
    @listing.build_van.amenities.build
    
  
  end

  # GET /listings/1/edit
  def edit
  end

    # Parameters: {"authenticity_token"=>"[FILTERED]", "listing"=>{"listing_image"=>#<ActionDispatch::Http::UploadedFile:0x00007f0b98c7ab78 @tempfile=#<Tempfile:/tmp/RackMultipart20211116-31511-ifytnf.jpg>, @original_filename="van3.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"listing[listing_image]\"; filename=\"van3.jpg\"\r\nContent-Type: image/jpeg\r\n">, "city"=>"sydney", "state"=>"nsw", "price"=>"2221", "van_attributes"=>{"seats"=>"3", "make"=>"mercedes", "amenities"=>{"amenity_ids"=>["", "4", "1", "6", "2", "3", "5"]}}, "description"=>"Another van I like"}, "commit"=>"Create Listing"}

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.new(listing_params)
    
    van_listing_amenities = params[:listing][:van_attributes][:amenities][:amenity_ids]
    # van_listing_amenities.each do |item|
    #   puts item
    #   # if item == 1 || item == 2 || item == 3 || item == 4
    #   #   @listing.van.amenities.push(Amenity.find(item))
    #   # end
    # end
    
        
    van_listing_amenities.each_with_index do |item, index|
      if index > 1
        AmenityVan.create(van_id: @listing.id, amenity_id: item )
      end
    end 


    @listing.save
    
    # @listing = current_user.listings.build(listing_params)

    # van_listing_amenities = params[:listing][:van_attributes][:amenities][:amenity_ids]
    
    # van_listing_amenities.each do |item|
    #   @amenity_van = AmenityVan.create {   }
    #   @amenity_van.van_id = @listing.van.id
    #   @amenity_van.amenity_id = item
    #   @amenity_van.save
    # end 


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
    
    #   params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:make, :model, :year, :odometer, :fuel_type, :listing_id, :type, :roof_type, :sleeps, :seats, amenity_ids: [], amenities_attributes: [:id, :name, :_destroy ]] )
    # end

    def listing_params
      params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:make, :model, :year, :odometer, :fuel_type, :listing_id, :type, :roof_type, :sleeps, :seats, amenities_vans_attributes: [:id, amenity_ids: [] ]] )
    end

    def set_amenities
      @amenities = Amenity.all

    def set_vans
      @vans = Van.all
    end

    def van_params
      params.require(:van).permit(:id, :amenities)
    end

    def amenity_params
      params.require(:amenities).permit(:id, :ammenity_name)
    end

    def set_amenity_vans
      @amenity_vans = AmenityVan.all
    end


end
