require "spec_helper"

describe "Authentication" do

  subject { page }

  before { visit login_path }
  describe "signin page" do


  it { should have_selector('h1',    text: 'Sign in') }

  end
end
