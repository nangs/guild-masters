class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end
  rescue ActionController::UnknownFormat
    render status: 404, text: "Error 404: Sorry, the url you have entered is not available\n\nPlease enter http://172.25.79.43:3000/ or http://127.0.0.1:3000/"
  end
end