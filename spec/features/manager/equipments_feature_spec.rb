require 'rails_helper'

RSpec.feature 'Manager Equipments', type: :feature do
  before do
    @tag1 = 'AAR-008-LB'
    @tag2 = 'MAR-004-B'
    create(:equipment, tag: @tag1)
    create(:equipment, tag: @tag2)
  end

  scenario 'list equipments' do
    visit manager_equipments_path

    expect(page).to have_text(@tag1)
    expect(page).to have_text(@tag2)
  end

  scenario 'create equipment' do
    visit new_manager_equipment_path

    @tag3 = 'AAR-021'
    find(:xpath, '//*[@id="equipment_tag"]').set(@tag3)
    click_button I18n.t('manager.equipments.new.save')

    expect(page).to have_text(@tag3)
  end

  scenario 'show equipment' do
    visit manager_equipments_path(Equipment.first)

    expect(page).to have_text(@tag1)
  end

  scenario 'update equipment' do
    visit manager_equipment_path(Equipment.last)
    click_link I18n.t('manager.equipments.show.edit')

    fill_in 'equipment_tag', with: 'CAAR-008'
    click_button I18n.t('manager.equipments.edit.save')

    expect(page).to have_text('CAAR-008')
  end

  scenario 'delete equipment on view show' do
    visit manager_equipment_path(Equipment.first)
    click_link I18n.t('manager.equipments.show.delete')

    page.accept_alert I18n.t('manager.equipments.show.delete_confirm')
    expect(page).not_to have_text(@tag1)
  end

  scenario 'delete equipment on view index' do
    visit manager_equipments_path

    click_button "#{Equipment.first.id}-dropdown-button"
    click_link I18n.t('manager.equipments.equipment.delete')
    page.accept_alert I18n.t('views.manager.goals.delete_confirm')

    expect(page).to have_text(@tag2)
    expect(page).not_to have_text(@tag1)
  end
end
