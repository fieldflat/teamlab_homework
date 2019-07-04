class StaticPagesController < ApplicationController
  def home
		@item = Item.new
  end
end
