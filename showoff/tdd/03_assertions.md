!SLIDE small

# TDD #

## assertions ##

	$ gem install cheat
	$ cheat minitest
	
	minitest:
	  capture_io
	  flunk msg = nil
	  pass  msg = nil
	  skip  msg = nil, bt = caller
	
	  assert             test, msg = nil
	  assert_equal       exp, act, msg = nil
	  ...
	
	  refute             test, msg = nil
	  refute_equal       exp, act, msg = nil
	  ...

