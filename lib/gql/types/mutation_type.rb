require 'graphql'
require_relative '../resolvers'

GQL::Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createStage, function: GQL::Resolvers::CreateStage.new
end
