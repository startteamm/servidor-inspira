class HomeController < ApplicationController
    def index
        respond_to do |format|
            format.html # Render HTML view
        end
    end
end