# Ruby on Rails Tutorial: sample application 

This is the sample application for 
[*Ruby on Rails Tutorial: Learn Rails by Example*](http://railstutorial.org/) 
by [Michael Hartl](http://michaelhartl.com/). 

as entered (and perhaps modified) by Lari Kirby


-----

## Issue

I still have a problem with the integration tests that sign in a user:

Michael Hartl says that signing in should look like this:

	user = Factory(:user)
	visit signin_path
	.
	.
	.

which makes perfect sense, but when I do that, the user created by the Factory disappears after the `visit signin_path`, and the sign-in fails. If I swap the two lines, the tests pass, but then I can't get [exercise 9.6.1](http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec:sign_in_out_exercises) to work (abstracting out the integration sign in step).

So I've tried to pinpoint where the Factory'd user disappears, by adding a *lot* of print statements (ugly but effective) and by concentrating on only one test:

	rspec spec/ -e "Users sign in/out success should sign a user in and out"

(Don't try to run the whole suite - the print statements will drive you crazy.)

So I can see now that the user is still there through the end of the page creation template for the `visit signin_path` command, yet it does not exist on the very next line after that command.

I'm stumped. What happens in between? How do I poke at it? OH! watch the test.log.... Well, the only enlightenment is that it only really asks the db for a user count at the beginning of the whole page, and returns caches of the query for the rest of the page. *But*, there's no delete nor truncate that I can see, *and yet* the second insert succeeds. Baffled.




