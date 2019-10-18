class Parking < ApplicationRecord
    # validations
    validates_presence_of :plate
    validates :plate, length: { minimum: 8 }
    validates :plate, format: { with: /\A[A-Z]{3}-[0-9]{4}\z/,
        message: "format is AAA-9999" }
end
