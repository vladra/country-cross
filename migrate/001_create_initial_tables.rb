Sequel.migration do
  change do
    create_table(:stages) do
      primary_key :id
      column :name, String, text: true, null: false
      column :location, String, text: false
      column :date, Date, null: false
      column :laps_amount, Integer
      column :lap_distance, BigDecimal
    end

    create_table(:vehicles) do
      primary_key :id
      column :brand, String, text: false, null: false
      column :model, String, text: false, null: false
    end

    create_table(:racers) do
      primary_key :id
      column :name, String, text: false, null: false
      column :nickname, String, text: false
      column :number, Integer, null: false, null: false

      foreign_key :vehicle_id, :vehicles, null: false

      unique %i[name number]
    end

    create_table(:racer_stages) do
      primary_key :id
      foreign_key :racer_id, :racers, null: false
      foreign_key :stage_id, :stages, null: false

      unique %i[racer_id stage_id]
    end

    create_table(:laps) do
      primary_key :id
      column :number, Integer, null: false
      column :time, :interval

      foreign_key :racer_stage_id, :racer_stages, null: false

      unique %i[number racer_stage_id]
    end
  end
end
