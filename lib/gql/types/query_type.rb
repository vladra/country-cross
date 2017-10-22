require 'graphql'

GQL::Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'

  field :stage_info do
    type GQL::Types::StageType
    argument :id, !types.ID
    description 'Find a Stage by ID'
    resolve -> (obj, args, ctx) {
      Stage.preload_by_id(args[:id])
    }
  end
end
