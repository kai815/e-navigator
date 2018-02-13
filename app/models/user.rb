class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :interviews
  enum gender: { man: 0, woman: 1 }

  def age
    if birth_date.present?
      (Date.today.strftime("%Y%m%d").to_i - birth_date.strftime("%Y%m%d").to_i) / 10000
    else
      return ""
    end
  end

  def approved_interiew
    Interview.find_by(status:1, user_id: self.id)
  end
end
