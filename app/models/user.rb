class User < ApplicationRecord
  before_validation :set_uuid

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  include DeviseTokenAuth::Concerns::User

  has_and_belongs_to_many :activities

  enum role: [:regular, :admin]
  enum gender: %i[homem_cis mulher_cis homem_trans 
                  mulher_trans nao_binario agenero neutro outro]
  
  validates :email, uniqueness: { case_sensitive: false }
  # validates :full_name, presence: true

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.full_name = auth.info.name
  #     user.avatar_url = auth.info.image
  #     user.skip_confirmation!
  #   end
  # end

  private

  def set_uuid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
