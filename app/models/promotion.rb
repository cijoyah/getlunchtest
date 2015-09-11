class Promotion < ActiveRecord::Base

  belongs_to :user

  scope :active, -> { where("end_time > ?", DateTime.current) }
  scope :expired, -> { where("end_time < ?", DateTime.current) }

  def is_active?
    DateTime.current < end_time && DateTime.current > start_time
  end

  def value_of_promotion_sold
    buyers*price
  end

end
