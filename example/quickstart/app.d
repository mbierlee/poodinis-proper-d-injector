/**
 * Poodinis Dependency Injection Framework
 * Copyright 2014-2020 Mike Bierlee
 * This software is licensed under the terms of the MIT license.
 * The full terms of the license can be found in the LICENSE file.
 */

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
