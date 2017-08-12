require 'spec_helper'
require 'imgurapi'

describe Imgurapi do

  it 'does an integration test by uploading, retrieving and deleting an image' do
    credentials = read_credentials_file
    @session = Imgurapi::Session.new(credentials)
    @upload_path, @upload_file = my_sample_image

    # Upload image
    image = @session.image.image_upload(@upload_path)

    # It is there
    expect(@session.account.image_count).to be > 0

    # Retrieve same image
    retrieved_image = @session.image.image(image.id)

    # Same, indeed
    expect(retrieved_image.id).to eq(image.id)

    # Delete image
    expect(@session.image.image_delete(image)).to eq true
  end
end
