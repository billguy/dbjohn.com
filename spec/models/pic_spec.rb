require 'spec_helper'

describe Pic do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:caption) }
  it { should have_attached_file(:attachment) }
  it { should callback(:notify_admin).after(:create) }
  it { should callback(:generate_token).before(:create) }
  it { should respond_to(:tag_list)}

  describe 'geocode' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
    end
    it 'geocodes images with gps exif' do
      pic = FactoryGirl.create(:pic_gps)
      p pic.inspect
      pic.location.should_not be_nil
    end
    it 'does not geocode images without gps exif' do
      pic = FactoryGirl.create(:pic)
      pic.location.should be_nil
    end
  end


  describe '#latest' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
    end

    it 'returns the latest pic' do
      pics = []
      5.times do
        pics << FactoryGirl.create(:pic, published: true)
      end
      latest = pics.last
      Pic.latest.first.should == latest
    end

  end

  describe '#filter_by' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
      FactoryGirl.create(:pic, published: true)
      FactoryGirl.create(:pic, published: true, created_at: 2.years.ago)
      FactoryGirl.create(:pic, published: true, created_at: 2.months.ago)
    end
    it 'returns all' do
      Pic.filter_by.length.should == 3
    end
    it 'filters by year' do
      Pic.filter_by('year').length.should == 2
    end
    it 'filters by month' do
      Pic.filter_by('month').length.should == 1
    end

  end

  describe '#notify_admin' do
    it 'should call PicMailer unless published' do
      pic = FactoryGirl.build(:pic)
      PicMailer.should_receive(:notify_admin).and_return( double("PicMailer", :deliver => true) )
      pic.save
    end

    it 'should not call PicMailer if published' do
      pic = FactoryGirl.build(:pic, published: true)
      PicMailer.should_not_receive(:notify_admin)
      pic.save
    end
  end

  describe '#generate_token' do
    it 'should generate a token' do
      pic = FactoryGirl.build(:pic)
      expect { pic.save }.to change{pic.token}
    end

    it 'should be 64 in length' do
      subject.send(:generate_token).length.should >= 16
    end

  end

  describe '#approve' do
    it 'should publish when a valid token' do
      pic = FactoryGirl.create(:pic)
      expect { pic.approve(pic.token) }.to change{pic.published}.to(true)

    end

    it 'should not publish when an invalid token' do
      pic = FactoryGirl.create(:pic)
      expect { pic.approve("invalid") }.not_to change{pic.published}.to(true)
    end
  end


end
