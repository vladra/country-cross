class Stage < Sequel::Model
  many_to_many :racers
  one_to_many :laps

  def self.preload_by_id(id)
    eager(:laps, racers: :vehicle)
      .where(id: id)
      .all
      .first
  end
end
