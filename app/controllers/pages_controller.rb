class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  self.layout "home"

  def index
  #   set_page_metadata(:home)
  end

  def about_us

  end

  def rooms

  end

  def room_one

  end

  def services

  end

  def cafe

  end

  def info

  end

  def publications

  end

  def publication_one

  end

  def contacts

  end

  private

  def set_page_instance
  #   set_page_metadata(action_name)
  end
end