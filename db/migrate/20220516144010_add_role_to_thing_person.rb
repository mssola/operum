class AddRoleToThingPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :thing_people, :role, :integer, default: ThingPerson.roles[:unknown]
  end
end
