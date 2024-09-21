class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_and_belongs_to_many :activities
  has_many :payments
  has_many :type_tickets, through: :payments
  has_many :tickets

  before_validation :set_uuid

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: %i[participante admin]
  enum gender: %i[homem_cis mulher_cis homem_trans mulher_trans nao_binario agenero neutro outro]

  validates :full_name, :phone, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :phone, format: { with: REGEX_TEL }

  validates :cpf, format: { with: REGEX_CPF }, allow_blank: true
  # validates :rg, format: { with: REGEX_RG }, allow_blank: true
  validates :birth_date, date: true, allow_blank: true
  validates :gender, inclusion: { in: genders.keys, message: 'invalid' }, allow_blank: true

  with_options if: :can_validate_account_update_params? do |u|
    u.validates :cpf, :address, presence: true
  end

  def gender=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('gender', value)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    user ||= User.create(name: data['name'],
                        email: data['email'],
                        password: Devise.friendly_token[0, 20])
    user
  end

  def enable_validate_account_update_params!
    self.validate_account_update_params = true
    save
  end

  def as_json_checkout
    {
      full_name: full_name,
      email: email,
      role: role,
      phone: phone,
      university: university,
      birth_date: birth_date,
      gender: gender,
      nationality: nationality,
      cpf: cpf,
      address: address
    }
  end

  private

  def can_validate_account_update_params?
    validate_account_update_params
  end

  def set_uuid
    self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
  end
end
