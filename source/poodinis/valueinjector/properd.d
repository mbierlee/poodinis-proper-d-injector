/**
 * A proper-d based value injector for Poodinis.
 *
 * Authors:
 *  Mike Bierlee, m.bierlee@lostmoment.com
 * Copyright: 2014-2016 Mike Bierlee
 * License:
 *  This software is licensed under the terms of the MIT license.
 *  The full terms of the license can be found in the LICENSE file.
 */

module poodinis.valueinjector.properd;

import poodinis;

import properd;

class ProperdValueInjector(Type) : ValueInjector!Type {
	private string[string] properties;

	this(string[string] properties) {
		this.properties = properties;
	}

	public override Type get(string key) {
		if (!(key in properties)) {
			throw new ValueNotAvailableException(key);
		}

		return properties.as!Type(key);
	}
}

alias ProperdIntValueInjector = ProperdValueInjector!int;
alias ProperdFloatValueInjector = ProperdValueInjector!float;
alias ProperdStringValueInjector = ProperdValueInjector!string;
alias ProperdBoolValueInjector = ProperdValueInjector!bool;

public void registerProperdProperties(shared(DependencyContainer) container, string[string] properties) {
	container.register!(ValueInjector!int, ProperdIntValueInjector).existingInstance(new ProperdIntValueInjector(properties));
	container.register!(ValueInjector!float, ProperdFloatValueInjector).existingInstance(new ProperdFloatValueInjector(properties));
	container.register!(ValueInjector!string, ProperdStringValueInjector).existingInstance(new ProperdStringValueInjector(properties));
	container.register!(ValueInjector!bool, ProperdBoolValueInjector).existingInstance(new ProperdBoolValueInjector(properties));
}
