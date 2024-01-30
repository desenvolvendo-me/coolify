require 'rails_helper'

# TODO: Problema com os testes de feature
RSpec.xfeature 'Manager Client', type: :feature do
  let(:admin_user) { create(:user, role: :admin) }
  let(:client_1_name) { FFaker::Name.name }
  let(:client_2_name) { FFaker::Name.name }
  let(:new_name) { FFaker::Name.name }
  let(:client) { create(:client, company: admin_user.company) }

  before do
    create(:client, name: client_1_name, company: admin_user.company)
    create(:client, name: client_2_name, company: admin_user.company)
    login_as(admin_user, scope: :user)
    ActsAsTenant.current_tenant = admin_user.company
  end

  scenario 'list clients' do
    visit manager_clients_path

    expect(page).to have_text(client_1_name)
    expect(page).to have_text(client_2_name)
  end

  scenario 'create client' do
    visit new_manager_client_path

    fill_in 'client[name]', with: new_name
    click_button I18n.t('helpers.submit.create', model: 'Client')

    expect(page).to have_current_path(manager_client_path(Client.last))
    expect(page).to have_text(I18n.t('manager.clients.show.title'))
    expect(page).to have_text(new_name)
  end

  scenario 'show client' do
    visit manager_client_path(client)

    expect(page).to have_text(I18n.t('manager.clients.show.title'))
  end

  scenario 'update client' do
    visit edit_manager_client_path(client)

    expect(page).to have_text(I18n.t('manager.clients.edit.title'))

    fill_in 'client[name]', with: new_name
    click_button I18n.t('helpers.submit.update', model: 'Client')

    expect(page).to have_current_path(manager_client_path(client))
    expect(page).to have_text(I18n.t('manager.clients.update.success'))
    expect(page).to have_text(I18n.t('manager.clients.show.title'))
    expect(page).to have_text(new_name)
    expect(new_name).to_not eq(client.name)
  end

  scenario 'access client creation page from index' do
    visit manager_clients_path

    click_button I18n.t('manager.clients.index.register_client')

    expect(page).to have_current_path(new_manager_client_path)
    expect(page).to have_text(I18n.t('manager.clients.new.title'))
  end

  scenario 'delete client from index' do
    visit manager_clients_path

    client_row = find('tr', text: client_1_name)
    client_row.find('[data-dropdown-toggle]').click
    client_row.find('a[data-turbo-method="delete"]').click
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_text(client_1_name)
    expect(page).to have_text(I18n.t('manager.clients.destroy.success'))
  end

  scenario 'show client page from index' do
    visit manager_clients_path

    client_row = find('tr', text: client_1_name)
    client_row.find('[data-dropdown-toggle]').click
    client_row.find('[data-test-id="client-index-show-link"]').click

    expect(page).to have_current_path(manager_client_path(Client.first))
    expect(page).to have_text(I18n.t('manager.clients.show.title'))
    expect(page).to have_text(client_1_name)
  end

  scenario 'access client editing page from index' do
    visit manager_clients_path

    client_row = find('tr', text: client_1_name)
    client_row.find('[data-dropdown-toggle]').click
    client_row.find('[data-test-id="client-index-edit-link"]').click

    expect(page).to have_current_path(edit_manager_client_path(Client.first))
    expect(page).to have_text(I18n.t('manager.clients.edit.title'))
  end

  scenario 'return to index from edit page' do
    visit edit_manager_client_path(client)

    click_link I18n.t('manager.clients.edit.go_back')

    expect(page).to have_current_path(manager_clients_path)
  end

  scenario 'show client page from edit page' do
    visit edit_manager_client_path(client)

    click_link I18n.t('manager.clients.edit.show')

    expect(page).to have_current_path(manager_client_path(client))
  end

  scenario 'return to index from show page' do
    visit manager_client_path(client)

    click_link I18n.t('manager.clients.show.go_back')

    expect(page).to have_current_path(manager_clients_path)
  end

  scenario 'access client editing page from show page' do
    visit manager_client_path(client)

    click_link I18n.t('manager.clients.show.edit')

    expect(page).to have_current_path(edit_manager_client_path(client))
  end

  scenario 'delete client from show page' do
    visit manager_client_path(client)

    click_link I18n.t('manager.clients.show.delete')
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_current_path(manager_clients_path)
    expect(page).to have_text(I18n.t('manager.clients.destroy.success'))
    expect(page).to_not have_text(client.name)
  end
end
