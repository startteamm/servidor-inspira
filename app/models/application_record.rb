class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  REGEX_TEL = /(^[0-9]{2})\s(9[0-9]{4})-([0-9]{4}$)/
  REGEX_CPF = /(^\d{3}\.\d{3}\.\d{3}-\d{2}$)/
  REGEX_RG = /(^\d{1,2}\.\d{3}\.\d{3}-\d{1,2}$)/
end
