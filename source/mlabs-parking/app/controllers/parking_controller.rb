class ParkingController < ApplicationController
    before_action :set_parking, only: [:update, :destroy]
    # before_action :set_parkings_by_plate, only: [:show]

    # GET /parking
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
        json_response({
            "id" => @parking.id, 
            "plate" => @parking.plate}, :created)
    end

    # # GET /parking/:plate
    # def show
    #     json_response(@parkings)
    # end

    # PUT /parking/:id
    def update
        @parking.update(parking_params)
        head :no_content
    end

    # DELETE /parking/:id
    def destroy
        @parking.destroy
        head :no_content
    end

    # GET /parking/:parking_id/pay
    def pay
        @parking = Parking.find(params[:parking_id])
        @parking.paid = true
        @parking.save
        json_response(@parking)
    end

    # GET /parking/:parking_id/out
    def out
        @parking = Parking.find(plate: params[:parking_id])
        if @parking.paid
            @parking.car_out = Time.now
            @parking.save
            diff_time = @parking.car_out - @parking.car_in
            minutes = (diff_time/60).to_i
            json_response({ 
                "id" => @parking.id,
                "time" => "%d minutes" % minutes,
                "paid" => @parking.paid, 
                "left" => true })
        else
            json_response({"message" => "payment required"}, 402)
        end
    end

    # GET /parking/:plate
    def historic

        if not params[:plate].match(/^[A-Z]{3}\-[0-9]{4}$/)
            return json_response({"message" => "invalid plate format"}, 400)
        end
        
        results = []
        Parking.where(plate: params[:plate]).find_each do |parking|
            if parking.car_out
                diff_time = parking.car_out - parking.car_in
                left= true
            else
                diff_time = Time.now - parking.car_in
                left= false
            end
            minutes = (diff_time/60).to_i
            results.push({
                "id" => parking.id,
                "time" => "%d minutes" % minutes,
                "paid" => true, 
                "left" => left
            })
        end

        if results != []
            json_response(results, :success)
        else
            json_response({"message" => "plate not found"}, 404)
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

    def set_parkings_by_plate
        @parkings = Parking.find_by plate:(params[:plate])
    end

end
