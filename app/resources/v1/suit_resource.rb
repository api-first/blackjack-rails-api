module V1
  class SuitResource < BaseResource
    include StringPrimaryKey
    include ReadOnlyResource

    attribute :initial
    attribute :color
  end
end
