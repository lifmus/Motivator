require 'spec_helper'

describe Pledge do
  before { @pledge = Fabricate(:pledge) }
  subject { @pledge }

  it { should validate_presence_of(:goal_id) }
  it { should validate_presence_of(:amount) }

end
