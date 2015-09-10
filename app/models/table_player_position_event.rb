class TablePlayerPositionEvent < ActiveRecord::Base
  belongs_to :table

  belongs_to :player

  enum events: [:join, :leave]
end
