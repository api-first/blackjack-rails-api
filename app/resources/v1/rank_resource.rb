module V1
  class RankResource < BaseResource
    include AlternatePrimaryKey
    include ReadOnlyResource

    attribute :initial
    attribute :name
  end
end
