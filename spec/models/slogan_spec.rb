require 'spec_helper'

describe Slogan do

  it { should validate_presence_of(:title)}

  it '#random' do
    Slogan.random.should_not raise_exception
  end
end
