require 'spec_helper'
require "navigatable"

describe Blog do

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:content)}
  it { should respond_to(:tag_list)}

  describe '#latest' do
    before do
      @blogs = []
      @blogs << FactoryGirl.create(:blog, published: true)
      @blogs << FactoryGirl.create(:blog, published: false)
      @blogs << FactoryGirl.create(:blog, published: true)
    end

    it 'returns published blogs' do
      Blog.latest(3).length.should == 2
    end

  end

  it_behaves_like "navigatable"

  describe '#filter_by' do
    before do
      @blogs = []
      @blogs << FactoryGirl.create(:blog, published: true)
      @blogs << FactoryGirl.create(:blog, published: false)
      @blogs << FactoryGirl.create(:blog, published: true, created_at: 2.months.ago)
    end
    it 'returns all for current_user' do
      Blog.filter_by(nil, false).length.should == 3
    end
    it 'returns published for guests' do
      Blog.filter_by.length.should == 2
    end
    it 'filters by year' do
      Blog.filter_by('year').length.should == 2
    end
    it 'filters by month' do
      Blog.filter_by('month').length.should == 1
    end

  end

end
