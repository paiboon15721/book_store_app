require 'rails_helper'
require 'support/macros'

RSpec.feature "creating Books" do
  let!(:peachpit) { Fabricate(:publisher, name: 'Peachpit Press') }
  let!(:author1) { Fabricate(:author) }
  let!(:author2) { Fabricate(:author) }
  let(:admin) { Fabricate(:admin) }

  before do
    sign_in_as admin
  end

  scenario "with valid inputs succeeds" do
    visit root_path

    click_link "Books", exact: true
    click_link "Add New book"

    fill_in "Title", with: "Javascript"
    fill_in "Isbn", with: "9780321772978"
    fill_in "Page count", with: 518
    fill_in "Price", with: 34.99
    fill_in "Description", with: "Learn Javascript the quick and easy way"
    fill_in "Published at", with: "2012-01-01"
    select "Peachpit Press", from: "Publisher"
    attach_file "Book cover", "app/assets/images/itext.jpg"
    check author1.full_name
    check author2.full_name

    click_button "Create Book"

    expect(page).to have_content('Book has been created')
  end
end
