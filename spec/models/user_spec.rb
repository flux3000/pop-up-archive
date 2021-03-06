require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }

  it 'gets a holding collection automatically' do
    user.uploads_collection.should_not be_nil
  end

  context '#uploads_collection' do
    it 'is a collection' do
      user.uploads_collection.should be_a Collection
    end

    it 'returns the same collection across multiple calls' do
      user.uploads_collection.should eq user.uploads_collection
    end

    it 'is persisted in the database' do
      user.uploads_collection.should be_persisted
    end

    it 'works when the user is not saved' do
      user = FactoryGirl.build :user
      user.uploads_collection.should eq user.uploads_collection
    end

    it 'saves with the user' do
      user = FactoryGirl.build :user
      collection = user.uploads_collection

      user.save.should be true

      user.should be_persisted
      collection.should be_persisted
      user.uploads_collection.should eq collection
    end
  end
end
