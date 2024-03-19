class AddImageurlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :imageurl, :string
  end
end
