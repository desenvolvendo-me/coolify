require 'rails_helper'

RSpec.feature 'Manager coolers', type: :feature do
  let(:admin_user) { create(:user, role: :admin) }

  before do
    @tag1 = 'AAR-008-LB'
    @tag2 = 'MAR-004-B'
    create(:cooler, tag: @tag1)
    create(:cooler, tag: @tag2)
    login_as(admin_user, scope: :user)
  end

  scenario 'list coolers' do
    visit manager_coolers_path

    expect(page).to have_text(@tag1)
    expect(page).to have_text(@tag2)
  end

  scenario 'create cooler' do
    visit new_manager_cooler_path

    @tag3 = 'AAR-021'
    find(:xpath, '//*[@id="cooler_tag"]').set(@tag3)
    click_button I18n.t('manager.coolers.new.save')

    expect(page).to have_text(@tag3)
  end

  scenario 'show cooler' do
    visit manager_coolers_path(cooler.first)

    expect(page).to have_text(@tag1)
  end

  scenario 'update cooler' do
    visit manager_cooler_path(cooler.last)
    click_link I18n.t('manager.coolers.show.edit')

    fill_in 'cooler_tag', with: 'CAAR-008'
    click_button I18n.t('manager.coolers.edit.save')

    expect(page).to have_text('CAAR-008')
  end

  scenario 'delete cooler on view show' do
    visit manager_cooler_path(cooler.first)
    click_link I18n.t('manager.coolers.show.delete')

    page.accept_alert I18n.t('manager.coolers.show.delete_confirm')
    expect(page).not_to have_text(@tag1)
  end

  scenario 'delete cooler on view index' do
    visit manager_coolers_path

    click_button "#{cooler.first.id}-dropdown-button"
    click_link I18n.t('manager.coolers.cooler.delete')
    page.accept_alert I18n.t('views.manager.goals.delete_confirm')

    expect(page).to have_text(@tag2)
    expect(page).not_to have_text(@tag1)
  end
end
