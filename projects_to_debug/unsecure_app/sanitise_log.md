06 Securing User Input

No example to follow or use to help with the exercise.  

First step I went with is to look at the hello.erb file.  Googled how to escape HTML in Sinatra: https://sinatrarb.com/faq.html#escape_html

Rack::Utils.escape_html(@name) added which seems to stop the attack.  Adding the same to app.rb and checking rspec.

RSpec working and website still working with the attack still broken.