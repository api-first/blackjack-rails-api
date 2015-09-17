class Player < ActiveRecord::Base

  belongs_to :user

  has_many :table_player_positions

  has_many :wagers

  has_many :transactions

  validates :user, presence: true

  after_commit :_credit_account, on: [:create]

  def balance
    transactions.sum(:amount)
  end

  def _credit_account
    transactions.create(kind: "credit", amount: 1000)
  end
  
  def  win_percentage
    if (wins + losses) == 0
      0
    else
      100*wins/(wins+losses)
    end
  end

end
