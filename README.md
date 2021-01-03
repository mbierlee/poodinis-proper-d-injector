Proper-d-based value injector for Poodinis
=======================================
Version 0.1.0  
Copyright 2014-2021 Mike Bierlee  
Licensed under the terms of the MIT license - See [LICENSE.txt](LICENSE.txt)

Master: [![Build Status](https://api.travis-ci.org/mbierlee/poodinis-proper-d-injector.png?branch=master)](https://travis-ci.org/mbierlee/poodinis-proper-d-injector) - Dev: [![Build Status](https://api.travis-ci.org/mbierlee/poodinis-proper-d-injector.png?branch=develop)](https://travis-ci.org/mbierlee/poodinis-proper-d-injector)

This is a [proper-d]-based value injector for the [Poodinis dependency injection framework](https://github.com/mbierlee/poodinis)

Requires at least a D 2.068.2 compatible compiler  
Uses the Phobos standard library  
Can be built with DUB 1.1.1 or higher

Getting Started
==========
### DUB Dependency
See the [DUB project page](https://code.dlang.org/packages/poodinis-proper-d-injector) for instructions on how to include this value injector into your project. You might also need to add [Poodinis](https://code.dlang.org/packages/poodinis) to your project.

### Quickstart
```d
import poodinis;
import poodinis.valueinjector.properd;
import properd;

class HttpServer {
	@Value("http.port")
	private int port = 80;

	public void start() {
		import std.stdio, std.conv;
		writeln("Started server on port " ~ port.to!string);
	}
}

void main() {
	auto container = new shared DependencyContainer();
	container.register!HttpServer;

	auto properties = parseProperties("http.port = 9000");
	container.registerProperdProperties(properties);

	auto server = container.resolve!HttpServer;
	server.start();
}
```
For more information on how to use proper-d, see the [proper-d] github page.

[proper-d]: https://github.com/free-beer/proper-d
