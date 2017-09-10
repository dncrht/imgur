require 'spec_helper'
require 'imgurapi'

describe Imgurapi do

  it 'does an integration test by uploading, retrieving and deleting an image' do
    session = Imgurapi::Session.new(credentials)

    # Upload image via path
    image = session.image.image_upload('sample.jpg')

    # Upload image via file
    image2 = session.image.image_upload(File.open('sample.jpg', 'r'))

    # Upload image via link
    image3 = session.image.image_upload('http://www.nationalcrimesyndicate.com/wp-content/uploads/2014/02/Ace.jpg')

    # It is there
    expect(session.account.image_count).to be > 0

    # Retrieve same image
    retrieved_image = session.image.image(image.id)

    # Same, indeed
    expect(retrieved_image.id).to eq(image.id)

    # Delete all images
    expect(session.image.image_delete(image)).to eq true
    expect(session.image.image_delete(image2)).to eq true
    expect(session.image.image_delete(image3)).to eq true
  end
end
