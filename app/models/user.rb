class User < ApplicationRecord

    before_validation :strip_whitespace

    has_secure_password
    has_many :users_station
    has_many :stations, through: :users_station
    has_many :notes
    # make custom validation for zip if not omniauth login
    # validates :zip, length: {is: 5}, numericality: true
    serialize :users_fuels, Array
    # after_create_commit :create_stations_for_state_job

    # def create_stations_for_state_job 
    #     CreateStationsForStateJob.perform_later(self.id)
    # end

    def strip_whitespace
        self.city = city.strip unless city.nil?
    end

    def check_settings(station)
        self.users_fuels.include?(station.fuel_type_code)
    end

    def self.from_omniauth(auth_hash)
        user = User.find_or_create_by(email: auth_hash['info']['email'])
        if user.id.nil?
            user.name = auth_hash['info']['name']         
            user.password = SecureRandom.hex(10)
            user.save
            user
        else
            user
        end
    end
end
