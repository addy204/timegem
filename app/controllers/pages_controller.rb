# frozen_string_literal: true

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def show
    @page = Page.where('lower(title) = ?', params[:title].downcase).first
    if @page.nil?
      redirect_to root_path, alert: 'Page not found.'
    else
      render template: 'pages/show'
    end
  end
end
