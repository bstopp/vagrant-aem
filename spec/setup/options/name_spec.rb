require 'spec_helper'
require 'options/name'
require 'stringio'

describe VagrantAem::BoxName do

  before :all do
    @inst = described_class.new
  end

  it 'should have a priority' do
    expect(@inst).respond_to?(:priority)
  end
end
