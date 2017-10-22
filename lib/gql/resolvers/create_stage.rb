require 'graphql'

module GQL
  class Resolvers::CreateStage < GraphQL::Function
    argument :name, !types.String
    argument :location, !types.String
    argument :date, !types.String
    argument :laps_amount, !types.Int
    argument :lap_distance, !types.Int

    type 'GQL::Types::StageType'

    def call(_obj, args, _ctx)
      Stage.create(
        name: args[:name],
        location: args[:location],
        date: args[:date],
        laps_amount: args[:laps_amount],
        lap_distance: args[:lap_distance]
      )
    end
  end
end
