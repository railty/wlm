class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :job_type
      t.string :input
      t.string :output
      t.string :state
      t.string :stdout
      t.string :stderr
      t.datetime :start
      t.datetime :finish

      t.timestamps null: false
    end
  end
end
