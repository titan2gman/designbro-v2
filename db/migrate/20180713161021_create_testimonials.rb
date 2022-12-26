class CreateTestimonials < ActiveRecord::Migration[5.1]
  def change
    create_table :testimonials do |t|
      t.string  :header,     null: false
      t.text    :body,       null: false
      t.integer :rating,     null: false, default: 1
      t.string  :credential, null: false
      t.string  :company,    null: false
      t.timestamps
    end
  end
end
