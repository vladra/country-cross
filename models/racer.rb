class Racer < Sequel::Model
  many_to_one :vehicle
  many_to_many :stages
  one_to_many :laps

  def laps_by_stage(stage_id)
    laps_dataset.where(stage_id: stage_id).all
  end
end
