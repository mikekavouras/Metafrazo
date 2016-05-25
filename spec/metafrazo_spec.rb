require 'spec_helper'

describe Metafrazo do
  it 'has a version number' do
    expect(Metafrazo::VERSION).not_to be nil
  end

  it 'is configurable' do
    Metafrazo.configure do |config|
      config.usernames = ["@metafrazo"]
    end
  end
end
