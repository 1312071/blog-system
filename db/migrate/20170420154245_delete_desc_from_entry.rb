class DeleteDescFromEntry < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :description
  end
end
