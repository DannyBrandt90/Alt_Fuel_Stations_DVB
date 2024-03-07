class Station < ApplicationRecord
    before_validation :format_phone_number
    has_many :users_station
    has_many :users, through: :users_station
    has_many :notes
    validates :name, presence: true
    validates :zip, presence: true, length: {is: 5}, numericality: {integer_only: true}
    validates :address, presence: true
    validates :access, presence: true
    validates :phone, format: {with: /\A\d{3}-\d{3}-\d{4}\z/, message: "should be formatted as xxx-xxx-xxxx"}
    serialize :outlets, Array

    scope :residential, -> {where(access: 'residential')}
    scope :users_zip, -> (zip) {where(zip: zip)}
    scope :users_city, -> (city, state) {where(city: city, state: state)}
    scope :users_state, -> (state) {where(state: state)}

    def format_phone_number
        if self.phone.present?
            number = phone.gsub(/\D/, '')
            self.phone = number.gsub(/(\d{3})(\d{3})(\d{4})/, '\1-\2-\3')
        end 
    end
end

