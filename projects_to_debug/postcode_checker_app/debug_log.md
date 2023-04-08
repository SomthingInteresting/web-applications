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












