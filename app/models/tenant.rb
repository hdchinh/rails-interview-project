class Tenant < ActiveRecord::Base
  before_create :generate_api_key

  validates :api_key, uniqueness: true
  validates :name, uniqueness: true

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
