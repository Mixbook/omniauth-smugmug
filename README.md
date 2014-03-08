OmniAuth SmugMug
================

This is an [OmniAuth 1.0](https://github.com/intridea/omniauth) strategy for authenticating to SmugMug.

Get a SmugMug API key [here](http://www.smugmug.com/hack/apikeys)

This fork adds the access and permissions options during the authorization phase.


Usage
-----

In a Rack application:

```ruby
use OmniAuth::Builder do
  provider :smugmug, ENV['SMUGMUG_KEY'], ENV['SMUGMUG_SECRET'], access: 'Full', permissions: 'Modify'
end
```

For Rails, put this in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :smugmug, ENV['SMUGMUG_KEY'], ENV['SMUGMUG_SECRET'], access: 'Full', permissions: 'Modify'
end
```


License
-------

Copyright (c) 2014 Wong Liang Zan.

This source code released under an MIT license.
