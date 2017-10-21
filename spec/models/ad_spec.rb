describe Ad do
it 'has valid factory' do
ad = build(:ad)
expect(ad).to be_valid
end
it 'is invalid without title' do
ad = build(:ad, title: '')
expect(ad).to_not be_valid
end
it 'is invalid without description' do
ad = build(:ad, description: '')
expect(ad).to_not be_valid
end
it 'is invalid without user'
ad = build(:ad, user: nil)
expect(ad).to_not be_valid
end
