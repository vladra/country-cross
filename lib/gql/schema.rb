require_relative 'types'

GQL::Schema = GraphQL::Schema.define do
  query GQL::Types::QueryType
  mutation GQL::Types::MutationType
end
