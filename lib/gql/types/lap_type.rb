require 'graphql'

GQL::Types::LapType = GraphQL::ObjectType.define do
  name 'Lap'

  field :id, !types.ID
  field :number, !types.Int
  field :time, !types.Int
  field :h_time, !types.String
  field :racer_id, !types.Int

  field :racer, !GQL::Types::RacerType
  field :stage, !GQL::Types::RacerType
end
