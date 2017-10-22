require 'graphql'

GQL::Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'

  field :stage do
    type GQL::Types::StageType
    description 'Find a Stage by ID'
    argument :id, !types.ID

    resolve -> (obj, args, ctx) {
      Stage.preload_by_id(args[:id])
    }
  end
end
