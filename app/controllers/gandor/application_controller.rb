class Gandor::ApplicationController < ApplicationController
  layout "gandor"
  before_filter :authenticate_user!

  inherit_resources
end
