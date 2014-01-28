require 'spec_helper'

describe Slogan do

  it { should validate_presence_of(:title)}

  it '#random' do
    expect { Slogan.random }.to_not raise_exception
  end

  it '#random' do
    FactoryGirl.create(:slogan, active:true)
    Slogan.random.should be_a_kind_of(Slogan)
  end
end
