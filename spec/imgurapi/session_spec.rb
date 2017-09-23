require_relative '../spec_helper'
require 'imgurapi'

describe Imgurapi::Session do

  context 'incorrect credentials' do
    it { expect { described_class.new }.to raise_error ArgumentError }
    it { expect { described_class.new(random_key: nil) }.to raise_error ArgumentError }
    it { expect { described_class.new(client_id: nil, random_key: nil) }.to raise_error ArgumentError }
    it { expect { described_class.new({}) }.to raise_error ArgumentError }
  end

  context 'correct credentials' do
    it do
      expect(
        described_class.new(client_id: 'ID', refresh_token: 'TOKEN', client_secret: 'SECRET',)
      ).to be_an_instance_of described_class
    end
  end
end
