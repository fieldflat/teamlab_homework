# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @item = Item.new
  end
end
