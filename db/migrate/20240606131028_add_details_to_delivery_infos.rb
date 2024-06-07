class AddDetailsToDeliveryInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :delivery_infos, :nom, :string
    add_column :delivery_infos, :prenom, :string
    add_column :delivery_infos, :adresse, :text
    add_column :delivery_infos, :code_postal, :string
    add_column :delivery_infos, :ville, :string
  end
end
