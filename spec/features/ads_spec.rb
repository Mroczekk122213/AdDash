require 'features_helper'
describe 'Ads' do
it 'creates ad' do
visit root_path
click_link 'Ogłoszenia'
click_link 'Dodaj zdjęcie'
expect(page).to have_content 'Nowe zdjęcie'
fill_in 'Tytuł', with: 'new_title'
fill_in 'Opis', with: 'new_description'
attach_file('Plik zdjęcia', "#{Rails.root}/spec/support/ror.png")
click_button 'Zapisz zdjęcie'
expect(page).to have_content 'Zamieszczono ogłoszenie!'
expect(Ad.count).to eq 1
ad = Ad.last
expect(ad.title).to eq 'new_title'
expect(ad.description).to eq 'new_description'
end
it 'updates ad' do
ad = create(:ad_with_file, title: 'title', description: 'description')
visit root_path
click_link 'Ogłoszenia'
click_link 'Edytuj'
expect(page).to have_content 'Edycja zdjęcia'
expect(page).to have_field('Tytuł', with: ad.title)
expect(page).to have_field('Opis', with: ad.description)
fill_in 'Tytuł', with: ''
fill_in 'Opis', with: 'updated_description'
click_button 'Zapisz zdjęcie'
ad.reload
expect(ad.title).to eq 'title'
expect(ad.description).to eq 'description'
expect(page).to have_content 'Nie można zaktualizować ogłoszenia!'
fill_in 'Tytuł', with: 'updated_title'
click_button 'Zapisz zdjęcie'
expect(page).to have_content 'Zaktualizowano ogłoszenie!'
ad.reload
expect(ad.title).to eq 'updated_title'
expect(ad.description).to eq 'updated_description'
end
end
