require 'graphql'

GQL::Types::VehicleType = GraphQL::ObjectType.define do
  name 'Vehicle'

  field :id, !types.ID
  field :brand, !types.String
  field :model, !types.String
end
