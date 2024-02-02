require 'rails_helper'

# TODO: Problema com os testes de feature
RSpec.xfeature 'Manager Maintenances', type: :feature do
  let(:admin_user) { create(:user, role: :admin) }

  before do
    create(:maintenance, date: Date.strptime('15-12-2023', '%d-%m-%Y'))
    create(:maintenance, date: Date.strptime('18-01-2024', '%d-%m-%Y'))
    login_as(admin_user, scope: :user)
  end

  scenario 'list maintenances' do
    visit manager_maintenances_path

    expect(page).to have_text('15/12/2023')
    expect(page).to have_text('18/01/2024')
  end

  scenario 'create maintenance' do
    visit new_manager_maintenance_path

    select('13', from: 'maintenance_date_3i')
    select('Outubro', from: 'maintenance_date_2i')
    select('2023', from: 'maintenance_date_1i')

    click_button I18n.t('manager.maintenances.new.save')

    expect(page).to have_text(I18n.t('manager.maintenances.create'))
    expect(page).to have_text('13/10/2023')
  end

  scenario 'show maintenance' do
    visit manager_maintenance_path(Maintenance.first)

    expect(page).to have_text('15/12/2023')
    expect(page).to_not have_text('18/01/2024')
  end

  scenario 'update maintenance' do
    visit manager_maintenances_path

    click_button "maintenance#{Maintenance.first.id}-dropdown-button"
    click_link I18n.t('manager.maintenances.maintenance.edit')

    select('22', from: 'maintenance_date_3i')
    select('Janeiro', from: 'maintenance_date_2i')
    select('2024', from: 'maintenance_date_1i')
    click_button I18n.t('manager.maintenances.edit.save')

    expect(page).to have_text(I18n.t('manager.maintenances.update'))
    expect(page).to have_text('22/01/2024')
  end

  scenario 'delete goal' do
    visit manager_maintenance_path(Maintenance.first)
    click_link I18n.t('manager.maintenances.show.delete')

    page.accept_alert I18n.t('manager.maintenances.show.delete_confirm')
    expect(page).to have_text(I18n.t('manager.maintenances.destroy'))
    expect(page).not_to have_text('15/12/2023')
  end
end
