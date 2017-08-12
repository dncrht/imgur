module EverythingAsExpected

  def read_credentials_file
    unless File.exist? 'credentials.json'
      raise "Please add a credentials.json file to the project directory containing your Imgur app_key, app_secret, access_token and access_token_secret. See credentials.json.example to get started."
    end

    credentials_file_contents = File.open('credentials.json', 'r').read
    credentials = JSON.parse(credentials_file_contents)
    if credentials.keys.count != 4 and credentials.keys & [:app_key, :app_secret, :access_token, :access_token_secret] != [:app_key, :app_secret, :access_token, :access_token_secret]
      raise "Your credentials.json file does contain all the required information. See credentials.json.example for more help."
    end

    credentials.inject({}) do |options, (key, value)|
      options[key.to_sym] = value
      options
    end
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
