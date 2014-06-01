require_relative '../spec_helper'
require 'imgur'

describe Imgur::Session do

  context 'incorrect credentials' do
    it { expect { Imgur::Session.new }.to raise_error }
    it { expect { Imgur::Session.new(random_key: nil) }.to raise_error }
    it { expect { Imgur::Session.new(client_id: nil, random_key: nil) }.to raise_error }
    it { expect { Imgur::Session.new({}) }.to raise_error }
  end

  context 'correct credentials' do
    it do
      expect(
        Imgur::Session.new(client_id: 'ID', client_secret: 'SECRET', refresh_token: 'TOKEN')
      ).to be_an_instance_of Imgur::Session
    end
  end
end
