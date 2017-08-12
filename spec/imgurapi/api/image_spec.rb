require_relative '../../spec_helper'
require 'imgurapi'

describe Imgurapi::Api::Image do

  before :all do
    credentials = read_credentials_file
    @session = Imgurapi::Session.new(credentials)
  end

  describe '#image' do
    it 'retrieves the image' do
      expect { @session.image.image(:not_an_image_id) }.to raise_error StandardError
      expect { @session.image.image('r4ndom 1d') }.to raise_error StandardError

      image = @session.image.image('12345')
      expect(image.error).to eq 'Unable to find an image with the id, 12345'
    end
  end

  describe '#image_upload' do
    it 'uploads the image' do
      expect { @session.image.image_upload('') }.to raise_error StandardError
      expect { @session.image.image_upload(:not_the_expected_object) }.to raise_error StandardError
    end
  end

  describe '#image_delete' do
    it 'deletes the image' do
      expect { @session.image.image_delete(:not_an_image_id) }.to raise_error StandardError
      expect { @session.image.image_delete('r4ndom 1d') }.to raise_error StandardError

      #expect(@session.image.image_delete('12345')).to eq true # is 200 when image does not exist?

      expect { @session.image.image_delete('valid_id') }.to raise_exception 'Retried 3 times but could not get an access_token'
    end
  end
end
