json.array!(@testimonials) do |testimonial|
  json.extract! testimonial, :id, :name, :testimonial, :provider, :picture
  json.url testimonial_url(testimonial, format: :json)
end
