require 'rails_helper'

RSpec.feature 'Manager Goals', type: :feature,  skip: true do
  before do
    create(:goal, name: 'Aprender Ruby')
    create(:goal, name: 'Aprender Rails')
  end

  scenario 'list goals' do
    visit manager_goals_path

    expect(page).to have_text('Aprender Ruby')
    expect(page).to have_text('Aprender Rails')
  end

  scenario 'list goals action done' do
    visit manager_goals_path

    expect(page).to have_text('Fazer')

    click_button "#{convert_to_id(Goal.first)}-dropdown-button"
    click_link I18n.t('views.manager.goals.done')

    expect(page).to have_text('Feito')
  end

  xscenario 'list goals action many done' do
    visit manager_goals_path

    expect(page).to have_text('Fazer')

    check "#{convert_to_id(Goal.first)}-checkbox"
    check "#{convert_to_id(Goal.last)}-checkbox"
    click_button 'actionsDropdownButton'
    click_link I18n.t('views.manager.goals.done')

    # TODO: Problema com javascript, parece que o capybara não
    # executa o javascript
    # expect(page).to have_text('Feito')
  end

  scenario 'create goal' do
    visit new_manager_goal_path

    find('#goal_name', match: :first).set('Aprender Ruby on Rails')
    click_button I18n.t('views.manager.goals.add_task')
    all(:css, '[id$=name]')[1].set('Curso de Ruby')
    all(:css, '[id$=name]')[2].set('Curso de Rails')
    click_button I18n.t('views.manager.goals.save')

    expect(page).to have_text('Meta cadastrada com sucesso.')
    expect(page).to have_text('Aprender Ruby on Rails')
    expect(page).to have_text('Curso de Ruby')
    expect(page).to have_text('Curso de Rails')
  end

  scenario 'show goal action done' do
    visit manager_goal_path(Goal.first)

    click_link I18n.t('views.manager.goals.done')

    expect(page).to have_text('Feito')
  end

  scenario 'show goal' do
    visit manager_goal_path(Goal.first)

    expect(page).to have_text('Aprender Ruby')
  end

  scenario 'update goal' do
    visit manager_goal_path(Goal.last)
    click_link I18n.t('views.manager.goals.edit')

    fill_in 'Nome', with: 'Aprender Ruby on Rails'
    fill_in 'Descrição', with: 'Criar projeto editora de livro'
    click_button I18n.t('views.manager.goals.save')

    expect(page).to have_text('Meta atualizada com sucesso.')
    expect(page).to have_text('Aprender Ruby on Rails')
  end

  scenario 'delete goal' do
    visit manager_goal_path(Goal.first)
    click_link I18n.t('views.manager.goals.delete')

    page.accept_alert I18n.t('views.manager.goals.delete_confirm')
    expect(page).to have_text('Meta apagada com sucesso.')
    expect(page).not_to have_text('Aprender Ruby')
  end
end
