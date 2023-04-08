Debugging Web Applications 

Exercise 1

- 4 RSpec failures
 - 3/4 are 404 errors

- Rackup initiated
- Same errors

- Check RSpec errors to see if any are unit tests
- All are integration test errors (app_spec)

- Drill down on first test error as it's different 
from the others and seems to have more info to go off
Thoughts: Seems like an ERB mismatch RSpec manages to 
receive a response but it's not matching the test expectation

Checked ERB and can see mismatch on name post_code which 
looks like it shouldn't have the underscore based on looking 
at the app.rb and other files (RSpec correct)

RSpec run and now 3 failures remain

On first glance the glaring issue seems to be the app.rb 
having get instead of post for /check

That cleared 2 more tests and 1 remains

This test again seems to indicate there's a mismatch between 
the ERB and test as we get a response but with not a matching result

Looking at the error code further I can see it say This is not a valid postcode.

Checking the POST route on postman and that also confirms the same.

The PostcodeChecker class tests would've failed if it wasn't working as intended so the issue is most likely in app.rb

Comparing the check.erb to the app.rb I can see the variable isn't correct in the latter.

Added @ to valid variable and now all tests pass along with correct output on postman.


Challenge

4/6 RSpec failures
Comprises of:
3 integration test failures over two spec files
1 unit test failure

RSpec fail message is very long for one test that it can't display all of it

Starting with unit test failure

The error code doesn't highlight anything obvious to me as the expectation and match seems to be the same. 

The issue is with the second test which on first glance has the same "it" 
as the first which is bad practice. Secondly for some reason 
has to_not include on the second expect and coding as the tag for music.

First thing to do is name it correctly so changed it to it 'adds two new posts' as that's what we're testing for.
I tested again with the expectation it will still fail and it does.

Now corrected the to_not. Failed as expected.
Now corrected the tag in the expect to 'music'. Still failed with same message.

Just noticed that the second test isn't actually looking at the all_posts method.  It's looking at the all_posts_by_tag.

I think I need to reverse the expect change I made back to coding and add back the to_not as I can now see that 
was the test to make sure it's not in that tag.

Now the it name has been changed to say it adds two new posts and checks the coding tag.

Time to look at the method which for some reason is looking at title when it should be looking at tags. 
RSpec passes for this now after fix. 

Rackup for the integration tests so we can check the client for clues.

Used rspec spec/ | less to view whole test (scrollable)

The first create_post_spec test is failing with 500 status which is internal server error. 
Which indicates to me that there's something wrong with the request and possibly the ERB.

The ERB body doesn't match the RSpec nor the real attributes.  Still the same error (status 500).  

Looking at the get / route it looks like posts needs to have @ in front.  Test passes and / path now shows the form.

Second test fails as it expects to have 'A new post in the body'.  The content is showing up in the test result.

Why is there an underscore in front of response in the test? I'm sure that's a mistake but I don't think it'll fix the test. 

Ok so if content is coming through then it could be a naming error.  Looking at the app.rb we can see the route reffering to the 'title' as 'the_title'.
Fixed and the test passes.

Final test is in list_posts_spec and the second test about tags fails.

First thought from looking is that we're testing for a GET but the route in the app is post. 

RSpec now passes. 
