class AddColorToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :color, :string
  end
end
