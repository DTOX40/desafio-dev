class StoresController < ApplicationController
  def index
    @stores = Store.all

    respond_to do |format|
      format.html
      format.json { render json: @stores }
    end
  end
end
