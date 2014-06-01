# Imgur

This gem allows you to interact with Imgur's authenticated API.

## Imgur set-up

In order to upload images to Imgur you are going to need an Imgur application. Using an application is the preferred way, because you get twice the credits (100 per hour) than uploading as an anonymous user.
Of course, if you have an Imgur application, you can skip this section.

To create an application visit https://imgur.com/register/api_oauth and fill the form. Pay attention to select these options:
- Application Type: Browser
- Access Type: Read & Write
 
Check your inbox, you will receive an email with your application Consumer Key and Consumer Secret. We are going to need them later on.

## Installation

Clone this project, build the gem and install it:
 
```bash
    $ git clone https://github.com/dncrht/imgur.git
    $ cd imgur
    $ gem build imgur.gemspec
    $ gem install imgur
```

Alternatively, you can add this line to your application's Gemfile:
```ruby
    gem 'imgur', :git => 'git://github.com/dncrht/imgur.git'
```

And then execute:
```bash
    $ bundle install
```

## Authorize your Ruby application

We now need to grant access to our Imgur user to Imgur the application, so we can upload images in his behalf. Type this and follow the instructions:
```bash
    $ rake imgur:authorize CLIENT_ID='CLIENT_ID' CLIENT_SECRET='CLIENT_SECRET'
    Visit this URL: http://api.imgur.com/oauth/authorize?oauth_token=xxx
    And after you approved the authorization please enter your verification code: yyy

    Authorization was successful. Use these credentials to initialize the library:

    access_token: ACCESS_TOKEN
    refresh_token: REFRESH_TOKEN
```

## Usage

Create a session object to communicate to Imgur.
```ruby
    imgur_session = Imgur::Session.new(client_id: 'CLIENT_ID', client_secret: 'CLIENT_SECRET', refresh_token: 'REFRESH_TOKEN')
```

Your account:
```ruby
    account = imgur_session.account
    {"id"=>1834609, "url"=>"robotyard", "bio"=>nil, "reputation"=>7, "created"=>1352279501, "pro_expiration"=>false}
```

How many images you have:
```ruby
    puts imgur_session.images_count
```

Upload your first image. Argument can be either a String or a File:
```ruby
    image = imgur_session.upload('portrait.jpg')
```

image is now an instance of Imgur::Image, a convenient way to manage all the attributes of your image (at least more convenient than a multilevel dictionary):
```ruby
name = nil
title = nil
caption = nil
hash = "xyzzy"
deletehash = "abcdef"
datetime = "2012-11-18 16:22:00"
type = "image/jpeg"
animated = "false"
width = 654
height = 273
size = 47584
views = 0
bandwidth = 0
links.imgur_page = "http://imgur.com/xyzzy"
links.delete_page = "http://imgur.com/delete/abcdef"
links.small_square = "http://i.imgur.com/xyzzys.jpg"
links.large_thumbnail = "http://i.imgur.com/xyzzyl.jpg"
links.original = "http://i.imgur.com/xyzzy.jpg"
```

Do you need to retrieve a previously uploaded image?
```ruby
    @my_image = imgur_session.find('hash_code')
```
Granted, another Image object. It will return nil if it could not find an image matching your hash.

Feel free to use it in your Rails views:
```ruby
    <%= image_tag @my_image.links.original %>
```

How many images do you have at the moment?
```ruby
    puts imgur_session.images_count
```

We want to delete some images. Argument can be either a String or an Image:
```ruby
    imgur_session.delete(image)
    imgur_session.delete('xyzzy')
```
It will return true if succeeded, false otherwise.


## Documentation
- http://api.imgur.com/resources_auth

