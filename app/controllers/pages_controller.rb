# frozen_string_literal: true

# app/controllers/pages_controller.rb

# Pages controller is used to define interaction with page elements

# Class defines methods for calling actions on page elements
class PagesController < ApplicationController
  def qr_code_generator; end

  def qr_code_download
    send_data RQRCode::QRCode.new(params[:content].to_s).as_png(size: 300), type: 'image/png',
                                                                            disposition: 'attachment'
  end
end
