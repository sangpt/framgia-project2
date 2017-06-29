require "rails_helper"

RSpec.describe "static_pages/help.html.erb", type: :view do
  include RSpecHtmlMatchers

  it "has tags" do
    render
    expect(rendered).to have_tag("h1") do
      with_text "Help"
    end
  end
end
