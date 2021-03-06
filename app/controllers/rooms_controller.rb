class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  caches_page :index, :show
  def index
    set_page_metadata(:rooms)
    set_page_banner
  end

  def show
    if @room
      set_page_metadata(@room)
      @banner = {
          title: @room.name,
          description: @room.banner_description,
          image: @room.banner_image.url(:xxl)
      }
    else
      render_not_found
    end
  end

  def reservation_request
    call_request_params = params[:reservation_request] || {}

    call_request = ReservationRequest.new(call_request_params)
    call_request.referer = request.referer
    call_request.session_id = session.id
    call_request.save

    if call_request.valid?
      call_request.notify_admin
    end

    data = {}
    render json: data, status: 201
  end

  def set_room
    @room = Room.published.joins(:translations).where(room_translations: { locale: I18n.locale, url_fragment: params[:id] }).first
  end
end