require 'spec_helper'
require "navigatable"
require "emailable"

describe Pic do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:caption) }
  it { should have_attached_file(:attachment) }
  it { should callback(:notify_admin).after(:create) }
  it { should callback(:generate_token).before(:create) }
  it { should respond_to(:tag_list)}

  it_behaves_like "navigatable"
  it_behaves_like "emailable"

  describe 'geocode' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
      Geocoder.configure(:lookup => :test)
      Geocoder::Lookup::Test.set_default_stub(
          [
              {
                  'latitude'     => 40.7143528,
                  'longitude'    => -74.0059731,
                  'address'      => 'New York, NY, USA',
                  'state'        => 'New York',
                  'state_code'   => 'NY',
                  'country'      => 'United States',
                  'country_code' => 'US'
              }
          ]
      )
    end
    it 'geocodes images with gps exif' do
      pic = FactoryGirl.create(:pic_gps, published: true)
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
      PicMailer.should_receive(:notify_admin).and_return( double("PicMailer", :deliver_now => true) )
      pic.save
    end

    it 'should not call PicMailer if published' do
      pic = FactoryGirl.build(:pic, published: true)
      PicMailer.should_not_receive(:notify_admin)
      pic.save
    end
  end

  describe '#generate_token' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
    end

    it 'should generate a token' do
      pic = FactoryGirl.build(:pic)
      expect{pic.save}.to change{pic.token}
    end

    it 'should be 64 in length' do
      subject.send(:generate_token).length.should >= 16
    end

  end

  describe '#approve' do
    before do
      Pic.any_instance.stub(:notify_admin).and_return(nil)
    end

    it 'should publish when a valid token' do
      pic = FactoryGirl.create(:pic)
      expect{pic.approve(pic.token)}.to change{pic.published}.to(true)
    end

    it 'should not publish when an invalid token' do
      pic = FactoryGirl.create(:pic)
      expect{pic.approve("invalid")}.to_not change{pic.published}
    end
  end

  describe 'exif' do

    before(:all) do
      @exif_pic = FactoryGirl.create(:pic_gps)
      @pic = FactoryGirl.create(:pic)
      @pic_without_gps = FactoryGirl.create(:pic_without_gps)
    end

    describe '#exif?' do
      it 'pic with exif' do
        expect(@exif_pic.exif?).to be true
      end

      it 'pic without exif' do
        expect(@pic.exif?).to be false
      end
    end

    it '#camera_make' do
      expect(@exif_pic.camera_make).to eq('Sony')
    end

    it '#camera_model' do
      expect(@exif_pic.camera_model).to eq('DSC-S600')
    end

    it '#f_stop' do
      expect(@exif_pic.f_stop).to eq(6.3)
    end

    it '#exposure_time' do
      expect(@exif_pic.exposure_time).to eq('1/250')
    end

    it '#date_taken' do
      expect(@exif_pic.date_taken).to eq('04.03.08 10:57AM')
    end

    it '#iso' do
      expect(@exif_pic.iso).to eq(80)
    end

    it '#latitude' do
      expect(@exif_pic.latitude).to eq(37.33027777777778)
      expect(@pic.latitude).to be nil
      expect(@pic_without_gps.longitude).to be nil
    end

    it '#longitude' do
      expect(@exif_pic.longitude).to eq(-121.895)
      expect(@pic.longitude).to be nil
      expect(@pic_without_gps.longitude).to be nil
    end

    it '#details' do
      expect(@exif_pic.details).to eq('f6.3, ISO 80, 1/250')
      expect(@pic.longitude).to be nil
      expect(@pic_without_gps.longitude).to be nil
    end

  end

  it 'should escape the attachment filename' do
    pic = FactoryGirl.create(:pic_with_crazy_filename)
    pic.attachment_file_name.should eq('a_crazy_file_name_.jpg')
  end

end
