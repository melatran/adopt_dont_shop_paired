class ChangeStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column :pets, :status, :string, default: "adoptable"
  end
end
