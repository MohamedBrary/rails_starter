class UserToken < ApplicationRecord
  belongs_to :user, required: true

  validates :access_token, presence: true, uniqueness: {case_sensitive: false}
  before_validation :set_access_token

  private

  # generate a unique access token
  def set_access_token
    self.access_token ||= loop do
      random_string = SecureRandom.hex(4).downcase
      break random_string if self.class.where(access_token: random_string).empty?
    end
  end

end
