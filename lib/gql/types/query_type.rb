require 'graphql'

GQL::Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'

  field :all_stages do
    type types[GQL::Types::StageType]
    description 'Fetch all stages'

    resolve -> (obj, args, ctx) {
      Stage.all
    }
  end

  field :stage do
    type GQL::Types::StageType
    description 'Find a Stage by ID'
    argument :id, !types.ID

    resolve -> (obj, args, ctx) {
      Stage.preload_by_id(args[:id])
    }
  end
end
