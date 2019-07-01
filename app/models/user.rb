class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :name

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

end
