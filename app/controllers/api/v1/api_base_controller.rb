module Api
  module V1
    class ApiBaseController < ApplicationController
      include Knock::Authenticable
    end
  end
end
