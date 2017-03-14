require 'spec_helper'

describe Page, type: :model do

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:content)}

end
