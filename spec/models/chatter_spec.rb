# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe Chatter do
  it "should be valid" do
    Chatter.new.should be_valid
  end
end
