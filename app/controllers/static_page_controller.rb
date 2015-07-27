class StaticPageController < ApplicationController

  def index
    @testimonials = Testimonial.all
  end

  def find_guest
    result = { status: true, error: nil }

    begin
      result[:data] = Guest.find_by_name(params[:name])
    rescue StandardError => e
      result[:status] = false
      result[:error] = e
    end

    render json: result
  end

  def confirm_guest
    result = { status: true, error: nil }

    begin
      Guest.update(params[:guest_id], { is_confirmed: true, confirmed_accompanying_number: params[:accompanying_number] })
      result[:data] = params
    rescue StandardError => e
      result[:status] = false
      result[:error] = e
    end

    render json: result
  end

  def autocomplete
    @guests_names = Guest.order(:name).where('name like ?', "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @guests_names.map(&:name)
      }
    end
  end

  def new_testimonial
    @testimonial = Testimonial.new

    render partial: 'layouts/add_testimonial_form', :layout => false
  end

  def create_testimonial(isFacebook = false)
    result = { status: true, error: nil }

    begin
      user = User.find_by(id: session[:user_id]) if isFacebook
      testimonial = Testimonial.new
      testimonial.name = isFacebook ? user.name : params[:name]
      testimonial.testimonial = params[:testimonial]
      testimonial.provider = isFacebook ? user.provider : 'none'
      testimonial.picture = isFacebook ? user.picture : view_context.image_path('face.png')
      testimonial.profile = isFacebook ? user.profile_link : 'none'
      testimonial.save
      result[:data] = testimonial
    rescue StandardError => e
      result[:status] = false
      result[:error] = e
    end

    render json: result
  end

  def testimonial_user
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    create_testimonial(true)
  end

  def save_testimonial

  end
end
