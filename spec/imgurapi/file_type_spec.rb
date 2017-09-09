require 'spec_helper'
require 'imgurapi'

describe Imgurapi::FileType do

  describe '#extension' do
    it 'returns the right types' do
      expect(described_class.new('sample.gif').extension).to eq 'image/gif'
      expect(described_class.new('sample.png').extension).to eq 'image/png'
      expect(described_class.new('sample.jpg').extension).to eq 'image/jpeg'
      expect(described_class.new('sample.jpg2').extension).to eq 'image/jpeg'
      expect(described_class.new('sample.txt').extension).to be_nil
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
end
