class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :name
      t.text :testimonial
      t.string :provider
      t.string :picture
      t.string :profile

      t.timestamps null: false
    end
  end
end
