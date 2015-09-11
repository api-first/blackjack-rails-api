class HandCard < ActiveRecord::Base
  include RankedModel

  belongs_to :hand

  validates :hand, presence: true

  validates :card_id, presence: true, inclusion: { in: Card.all.map(&:id) }

  ranks :order, with_same: [:hand_id]

  def card
    return unless card_id

    Card.find(card_id)
  end
end
