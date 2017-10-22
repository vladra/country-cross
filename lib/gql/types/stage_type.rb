require 'graphql'

module GQL
  Types::StageType = GraphQL::ObjectType.define do
    name 'Stage'
    description 'Race stage'

    field :id, !types.ID
    field :name, !types.String

    field :racers, types[!GQL::Types::RacerType]
    field :laps, types[!GQL::Types::LapType]
  end
end
