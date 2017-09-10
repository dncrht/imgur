require 'spec_helper'
require 'imgurapi'

describe Imgurapi::FileType do

  describe '#mime_type' do
    it 'returns the right types' do
      expect(described_class.new('sample.gif').mime_type).to eq 'image/gif'
      expect(described_class.new('sample.png').mime_type).to eq 'image/png'
      expect(described_class.new('sample.jpg').mime_type).to eq 'image/jpeg'
      expect(described_class.new('sample.jpg2').mime_type).to eq 'image/jpeg'
      expect(described_class.new('sample.txt').mime_type).to be_nil
    end
  end

  describe '#image?' do
    it 'returns true for images' do
      expect(described_class.new('sample.jpg').image?).to be true
    end

    it 'returns false for anything else' do
      expect(described_class.new('sample.txt').image?).to be false
    end
  end


  describe '#url?' do
    it 'returns true for a valid URL' do
      expect(described_class.new('http://domain.tld/sample.jpg').url?).to be true
      expect(described_class.new('https://domain.tld/sample.jpg').url?).to be true
      expect(described_class.new('ftp://domain.tld/sample.jpg').url?).to be true
    end

    it 'returns false for anything else' do
      expect(described_class.new('smb://sample.txt').url?).to be false
      expect(described_class.new('sample.txt').url?).to be false
    end
  end
end
