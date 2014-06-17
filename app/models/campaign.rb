class Campaign < ActiveRecord::Base
  belongs_to :organization
  has_many :requests
  has_many :pledges, through: :requests

  validates :name, presence: true
  validates :description, presence: true
  validates_length_of :description, maximum: 500

  def total_requests_price
    requests = self.requests
    requests.inject(0) do | total, request |
      total + request.quantity * request.requested_item.price_dollars
    end.round(2)
  end

  def total_pledges_price
    pledges = self.pledges
    pledges.inject(0) do | total, pledge |
      total + pledge.quantity * pledge.pledged_item.price_dollars
    end.round(2)
  end

  def percentage_goal_complete
    if total_pledges_price > 0
      ((total_pledges_price / total_requests_price) * 100).round
    else
      return 0
    end
  end

  def total_request_quantity
    requests = self.requests
    requests.pluck(:quantity).reduce(:+)
  end

  def total_pledge_quantity
    pledges = self.pledges
    pledges.pluck(:quantity).reduce(:+)
  end


end
