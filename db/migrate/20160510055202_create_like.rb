class CreateLike < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    t.references :micropost, index: true
    t.references :user, index: true
    end
  end
end
