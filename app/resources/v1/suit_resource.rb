module V1
  class SuitResource < BaseResource
    include AlternatePrimaryKey
    include ReadOnlyResource

    attribute :initial
    attribute :color

  end
end