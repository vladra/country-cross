require 'graphql'

GQL::Types::RacerType = GraphQL::ObjectType.define do
  name 'Racer'

  field :id, !types.ID
  field :name, !types.String
  field :nickname, !types.String
  field :number, !types.Int
  field :vehicle, GQL::Types::VehicleType

  field :stages, types[!GQL::Types::StageType]
  field :laps, types[!GQL::Types::LapType]

  field :laps_by_stage, types[!GQL::Types::LapType] do
    argument :stage_id, !types.ID

    resolve -> (obj, args, ctx) {
      obj.laps_by_stage(stage_id)
    }
  end
end
