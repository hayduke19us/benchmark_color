## benchmark_color

This is a simple realtime benchmark tool in color! 

####Installation

	gem install 'benchmark_color'

#### Getting Started
In the top of your file or in irb.
	
	require 'benchmark_color'
	
Create a new Benchmark object 

	b = Benchmark.new

Measure a block of code
	
	n = 10000
	b.measure("some-label:")	{n.times.do ; x = 1; end}
	
Use the Compare method to recieve an output

    b.compare

The whole thing together will look something like this. 

	b = Benchmark.new
	b.measure("some-label:") { YOUR BLOCK OF CODE} 
	b.compare
	   
You can measure as many blocks of code to be compared to one another as the same Benchmark object. For example.

	....
	b = Benchmark.new
	b.measure("some-label":) {YOUR BLOCK OF CODE}
	b.measure("some-label:") {YOUR BLOCK OF CODE}
    b.compare
       
####Customizing colors
When you create a Benchmark object just include the colors you prefer.
benchmark_color uses the awesome 'colorize ' gem so the colors need to be a symbol. 
By default the fastest block of code will be green and the slowest red.
Therfore winner: :green, loser: :red.

    b = Benchmark.new winner: :cyan, loser: :magenta, option: :yellow
     
The option: color argument is for the blocks of code that were neither fastest or slowest. 

Colorize is an extension to the String class.  To see a list of all the colors
just use:
	
	String.colors

####Screen Shots
File Setup

![file](http://i.imgur.com/MdQPkHR.png)	
	
Output

![output](http://i.imgur.com/Tr2oib3.png)

####Future Features
+ Process:Tms integration
+ More customizations
	
	
####Contributing to benchmark_color
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

###### Copyright

Copyright (c) 2014 Matthew Sullivan. See LICENSE.txt for
further details.

