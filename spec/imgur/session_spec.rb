require_relative '../spec_helper'
require 'imgur'

describe Imgurapiapi::Session do

  context 'incorrect credentials' do
    it { expect { Imgurapi::Session.new }.to raise_error }
    it { expect { Imgurapi::Session.new(random_key: nil) }.to raise_error }
    it { expect { Imgurapi::Session.new(client_id: nil, random_key: nil) }.to raise_error }
    it { expect { Imgurapi::Session.new({}) }.to raise_error }
  end

  context 'correct credentials' do
    it do
      expect(
        Imgurapi::Session.new(client_id: 'ID', client_secret: 'SECRET', refresh_token: 'TOKEN')
      ).to be_an_instance_of Imgurapi::Session
    end
  end
end
