class CreateMatchRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :match_records do |t|
      t.string :home_team
      t.string :opponent
      t.date   :match_date
      t.string :match_type
      t.string :result
      t.string :home_score
      t.string :opponent_score

      t.timestamps
    end
  end
end
