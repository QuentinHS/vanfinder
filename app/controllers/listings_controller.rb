class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ show edit update destroy ]
  # This throws an exception if the user is not authenticated
  before_action :authenticate_user!, except: %i[ index show ]
  
  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
    # Pundit authorisation for show view
     authorize @listing
  end

  # GET /listings/new
  def new
    # @listing = current_user.listings.build
    @listing = Listing.new
    # @listing.van.new
    # # Create van linked to each new listing
    # @listing.van.create
    # @listing = Listing.new
    # @listing.van.build
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = current_user.listings.build(listing_params)
    # @listing = current_user.listings.new(listing_params)
 
    # van_hash = params[:listing][:van]
    # if van_hash
    #   @van = Van.create
    #   @van.seats = van_hash[:seats]
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

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:city, :state, :sold, :description, :user_id, :price, :listing_image, van_attributes: [:listing_id, :seats] )
    end


end
