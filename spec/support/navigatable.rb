shared_examples_for "navigatable" do

  let(:object) { described_class }
  describe 'next, prev' do
    before do
      @object1 = FactoryGirl.create(described_class.name.underscore.to_sym, published: true)
      @object2 = FactoryGirl.create(described_class.name.underscore.to_sym, published: true)
      @object3 = FactoryGirl.create(described_class.name.underscore.to_sym, published: true)
    end

    it '#prev' do
      @object2.prev.should == @object1
    end
    it '#prev' do
      @object1.prev.should == nil
    end
    it '#next' do
      @object1.next.should == @object2
    end
    it '#next' do
      @object3.next.should == nil
    end
  end

end