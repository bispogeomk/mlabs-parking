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
        @parking.car_in = Time.now
        @parking.car_out = nil
        @parking.save
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

    # GET /parking/:id/pay
    def pay
        @parking = Parking.find(params[:parking_id])
        @parking.paid = true
        @parking.save
        json_response(@parking)
    end

    # GET /parking/:id/out
    def out
        @parking = Parking.find(params[:parking_id])
        if @parking.paid
            @parking.car_out = Time.now
            json_response(@parking)
        else
            # head 402
            json_response({"message" => "payment required"}, 402)
        end
    end

    private

    def parking_params
        # whitelist params
        params.permit(:plate)
    end

    def set_parking
        @parking = Parking.find(params[:id])
    end

    def set_parking_by_plate
        @parking = Parking.find(params[:plate])
    end

end
