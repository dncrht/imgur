require 'spec_helper'
require 'imgurapi'

describe Imgurapi do

  it 'does an integration test by uploading, retrieving and deleting an image' do
    credentials = read_credentials_file
    session = Imgurapi::Session.new(credentials)

    # Upload image via path
    image = session.image.image_upload('sample.jpg')

    # Upload image via file
    image2 = session.image.image_upload(File.open('sample.jpg', 'r'))

    # It is there
    expect(session.account.image_count).to be > 0

    # Retrieve same image
    retrieved_image = session.image.image(image.id)

    # Same, indeed
    expect(retrieved_image.id).to eq(image.id)

    # Delete both images
    expect(session.image.image_delete(image)).to eq true
    expect(session.image.image_delete(image2)).to eq true
  end
end
