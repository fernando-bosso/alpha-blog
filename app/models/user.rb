class User < ActiveRecord::Base
  has_many :articles

  before_save { self.email = email.downcase }

  validates :username, presence:true,
            uniqueness:{ case_sensitive: false, message: "Erro Caralho" }, 
            length:{minimum: 3, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:true, 
            length:{maximum: 105},
            uniqueness:{case_sensitive: false, message:"Erro Caralho"},
            format: {with: VALID_EMAIL_REGEX }
  validates :password, presence: true

  has_secure_password

end