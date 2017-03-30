class Account::GroupsController < ApplicationController
  before_action :logged_in_user

  def index
    @groups = current_user.participated_groups
  end
end
