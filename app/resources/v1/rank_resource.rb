module V1
  class RankResource < BaseResource
    include StringPrimaryKey
    include ReadOnlyResource

    attribute :initial
    attribute :name
    attribute :values
  end
end
