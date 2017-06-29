require "rails_helper"

RSpec.describe "static_pages/contact.html.erb", type: :view do
  include RSpecHtmlMatchers

  it "has tags" do
    render
    expect(rendered).to have_tag("h1") do
      with_text "Contact"
    end
  end
end
