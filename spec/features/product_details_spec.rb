require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see one specific product" do
    # ACT
    visit root_path

    page.find(:xpath, "/html/body/main/section/div/article[1]/header/a").click
    # first('article.product a h4').click

    # DEBUG
 
    # VERIFY
    # expect(page).to have_css 'article.product', count: 10

    expect(page).to have_css('.products-show')
    save_screenshot
  end
end
