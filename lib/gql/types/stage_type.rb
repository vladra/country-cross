require 'graphql'

module GQL
  Types::StageType = GraphQL::ObjectType.define do
    name 'Stage'
    description 'Race stage'

    field :id, !types.ID
    field :name, !types.String
    field :location, !types.String
    field :date, !types.String
    field :laps_amount, !types.Int
    field :lap_distance, !types.Int

    field :racers, types[!GQL::Types::RacerType]
    field :laps, types[!GQL::Types::LapType]
  end
end
