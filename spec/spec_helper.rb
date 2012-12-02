module EverythingAsExpected

  def read_keys_file
    unless File.exist? 'keys.json'
      raise "Please add a keys.json file to the project directory containing your Imgur app_key, app_secret, access_token_key and access_token_secret. See keys.json.example to get started."
    end
    
    keys_file_contents = open('keys.json', "r").read
    data = JSON.parse(keys_file_contents)
    unless data.count == 4
      raise "Your keys.json file does contain all the required information. See keys.json.example for more help."
    end
    
    data
  end

  def my_sample_image
    unless File.exist? 'sample.jpg'
      raise "Please add a sample.jpg file to the project directory to test upload and download. Recommended size: under 30kB"
    end
    
    ['sample.jpg', File.open('sample.jpg', 'r')]
  end

end

RSpec.configure do |config|
  config.include(EverythingAsExpected)
end
