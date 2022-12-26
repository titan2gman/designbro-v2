# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable,
         :recoverable,
         :validatable,
         :rememberable,
         :database_authenticatable
end
