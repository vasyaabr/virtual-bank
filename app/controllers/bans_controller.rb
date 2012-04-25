#encoding: utf-8
class BansController < ApplicationController
  before_filter :authenticate
  before_filter :isadmin?

  def index
    @bans = Ban.all
  end

end
