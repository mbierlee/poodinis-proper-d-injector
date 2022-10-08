/**
 * Poodinis Dependency Injection Framework
 * Copyright 2014-2022 Mike Bierlee
 * This software is licensed under the terms of the MIT license.
 * The full terms of the license can be found in the LICENSE file.
 */

import poodinis;
import poodinis.valueinjector.properd;
import properd;
import std.exception;

version(unittest) {

    class Config {
        @Value("number")
        public int number;

        @Value("floatyNumber")
        public float floatyNumber;

        @Value("text")
        public string text = "This text is overwritten";

        @Value("boolean")
        public bool boolean;

        @Value("doesnotexist")
        public int notThere = 8877;
    }

    class MissingConfig {
        @MandatoryValue("doesnotexist")
        public int number;
    }

    private string propertyText = `
        number = 42
        floatyNumber = 1.23
        text = And then the sky opened up
        boolean = true
    `;

    // Test injection of proper-d config
    unittest {
        auto container = new shared DependencyContainer();
        auto properties = parseProperties(propertyText);
        container.registerProperdProperties(properties);
        container.register!Config;
        auto config = container.resolve!Config;

        assert(config.number == 42);
        assert(config.floatyNumber >= 1.23 && config.floatyNumber < 1.24);
        assert(config.text == "And then the sky opened up");
        assert(config.boolean == true);
        assert(config.notThere == 8877);
    }

    // Test injection of non-existant mandatory values
    unittest {
        auto container = new shared DependencyContainer();
        string[string] properties;
        container.registerProperdProperties(properties);
        container.register!MissingConfig;
        assertThrown!ResolveException(container.resolve!MissingConfig);
    }

}
