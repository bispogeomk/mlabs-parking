class ParkingController < ApplicationController
    before_action :set_parking, only: [:show, :update, :destroy]

    # GET /parkings
    def index
        @parkings = Parking.all
        json_response(@parkings)
    end

    # POST /parkings
    def create
        @parking = Parking.create!(parking_params)
        json_response(@parking, :created)
    end

    # GET /parkings/:id
    def show
        json_response(@parking)
    end

    # PUT /parkings/:id
    def update
        @parking.update(parking_params)
        head :no_content
    end

    # DELETE /parking/:id
    def destroy
        @parking.destroy
        head :no_content
    end

    private

    def parking_params
        # whitelist params
        params.permit(:plate, :in_car, :out_car, :paid)
    end

    def set_parking
        @parking = Parking.find(params[:id])
    end

end
