require_relative '../../spec_helper'
require 'imgurapi'

describe Imgurapi::Image do

  it 'creates an Image with the fields provided' do
    image = Imgurapi::Image.new(a: 1, b: 2)

    expect(image.a).to eq 1
    expect(image.b).to eq 2
  end

  it 'returns a download URL' do
    image = Imgurapi::Image.new(id: 'hash')

    expect(image.url).to eq "http://i.imgur.com/hash.jpg"
    expect(image.url(:random_size)).to eq "http://i.imgur.com/hash.jpg"
    expect(image.url(:small_square)).to eq "http://i.imgur.com/hashs.jpg"
    expect(image.url(:large_thumbnail)).to eq "http://i.imgur.com/hashl.jpg"
  end
end
