# Imgur

This gem allows you to interact with Imgur's authenticated API, version 3.

It doesn't implement all the available endpoints. So far:
- image upload, find and delete
- account image count, account details, account image list

## Imgur set-up

In order to upload images to Imgur you are going to need an Imgur application. Using an application is the preferred way, because you get twice the credits (100 per hour) than uploading as an anonymous user.
Of course, if you already have an Imgur application, you can skip this section.

To create an application visit https://imgur.com/register/api_oauth and fill the form. Pay attention to select these options:
- Application Type: Browser
- Access Type: Read & Write

Check your inbox, you will receive an email with your application Client Id and Client Secret. We are going to need them later on.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'imgurapi'
```

And then run:
```bash
$ bundle install
```

## Authorize your Ruby application

We now need to grant access to our Imgur user to Imgur the application, so we can upload images in his behalf. Type this and follow the instructions:
```bash
$ rake imgur:authorize CLIENT_ID='CLIENT_ID' CLIENT_SECRET='CLIENT_SECRET'
Visit this URL: http://api.imgur.com/oauth/authorize?oauth_token=xxx
And after you approved the authorization please enter your verification code: yyy

Authorization was successful. These are your credentials to initialize the library:
```

Copy the credentials shown as JSON or YAML, depending how you're going to use this library.

## Usage and overview

Create a session object to communicate to Imgur.
```ruby
imgur_session = Imgurapi::Session.instance(client_id: 'CLIENT_ID', client_secret: 'CLIENT_SECRET', refresh_token: 'REFRESH_TOKEN')
```

Your account:
```ruby
account = imgur_session.account.account
=> #<Imgurapi::Account:0x007fd399b6b678 @id=123, @url="my_account", @bio=nil, @reputation=7, @created=1352279501, @pro_expiration=false>
```

How many images you have:
```ruby
puts imgur_session.account.image_count
```

Upload your first image. Argument can be either a String or a File:
```ruby
image = imgur_session.image.image_upload('portrait.jpg')
```

image is now an instance of Imgurapi::Image, a convenient way to manage all the attributes of your image (at least more convenient than a multilevel dictionary):
```ruby
name = nil
title = nil
caption = nil
id = "xyzzy"
deletehash = "abcdef"
datetime = "2012-11-18 16:22:00"
type = "image/jpeg"
animated = "false"
width = 654
height = 273
size = 47584
views = 0
bandwidth = 0
link = "http://imgur.com/xyzzy"
```

Do you need to retrieve a previously uploaded image?
```ruby
my_image = imgur_session.image.image('id_code')
```
Granted, another Image object. It will error if it could not find an image matching the id.

Feel free to use it in your Rails views:
```ruby
<%= image_tag my_image.link %>
```

Alternatively, you can use `url` instead of `link` because it provides image resizing.
```
<%= image_tag my_image.url %>
<%= image_tag my_image.url(:small) %>
```
With no arguments, it's the same as `link`.
Available sizes are small (`:small_square`, `:small` or `:s`) and large (`:large_thumbnail`, `:large` or `:l`)

How many images do you have at the moment?
```ruby
puts imgur_session.account.image_count
```

We want to delete some images. Argument can be either a String or an Image:
```ruby
imgur_session.image.image_delete(image)
imgur_session.image.image_delete('xyzzy')
```
It will return true if succeeded, false otherwise.

## Available endpoints

Not all the endpoints available at https://api.imgur.com/ have been implemented.
Feel free to suggest or pull request your needs.

The API methods have been named following Imgur's endpoints, for easy mental mapping.
Although I consider this is clearer, in the future it may change to follow the naming conventions of the official Python API.

| Type | API method | Imgur doc URL |
|---|---|---|
| Account | account.account | https://api.imgur.com/endpoints/account#account |
| Account | account.images | https://api.imgur.com/endpoints/account#images |
| Account | account.image_count | https://api.imgur.com/endpoints/account#image-count |
| Image | image.image | https://api.imgur.com/endpoints/image#image |
| Image | image.image_upload | https://api.imgur.com/endpoints/image#image-upload |
| Image | image.image_delete | https://api.imgur.com/endpoints/image#image-delete |

## Accessing more than one account at once

Imgur's ACCESS_TOKEN expires after 1 month. When you make an API request, if the ACCESS_TOKEN is invalid, the library will attempt to get a new one via the REFRESH_TOKEN. This new ACCESS_TOKEN will live with the instance of the library, if you instantiated the Imgurapi::Session with `.new`. So if you instantiate a new session, the token will be requested again.

Given requesting a new ACCESS_TOKEN on every API call is slow, the recommended way of using Imgurapi::Session is via `.instance`, not `.new` so it requests a fresh ACCESS_TOKEN only once, which will be stored at class level, reducing optimally the number of token requests.

This approach is not feasible if you want to handle several Imgur accounts at once.

In short:
 - instantiate Imgurapi::Session via `.instance` if you manage 1 account
 - instantiate Imgurapi::Session via `.new` if you manage 2 or more accounts
