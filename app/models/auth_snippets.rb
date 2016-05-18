class User < ActiveRecord::Base
  has_many :questions, foreign_key: :author_id
  has_many :answers, foreign_key: :theOneWhoAnswers_id
  has_many :responses
  has_many :votes, foreign_key: :voter_id

  # validate :validate_password

  def password=(plaintext_password)
    @plaintext_password = plaintext_password
    @hashword_obj = BCrypt::Password.create(plaintext_password)
    self.hashword = @hashword_obj
  end

  def password
    @hashword_obj ||= BCrypt::Password.new(self.hashword)
  end

  def authenticate(plaintext_password)
    self.password == plaintext_password
  end

  def validate_password
    self.errors.add(:password, 'You password should contain more than 6 characters. Dummy.') if @plaintext_password.length < 6
  end
end
