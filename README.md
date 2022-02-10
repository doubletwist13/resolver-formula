resolver-formula {#readme}
================

[![Travis CI Build Status](https://travis-ci.com/saltstack-formulas/resolver-formula.svg?branch=master)](https://travis-ci.com/saltstack-formulas/resolver-formula)
[![Semantic Release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A saltstack formula to configure the dns resolver(s) a server will use.
 
Known Issues
-------------
    - Although This formula follows the 'v5' template-formula as a template, I don't yet know how to get the test stuff working (I'm don't come from a development background) - so don't expect that to work at all at this time. Hopefully soon I'll have time to figure that out and add it to all of my formulas.

Available states
----------------

::: {.contents local=""}
:::

### `resolver`

*Meta-state (This is a state that includes other states)*.

This installs the resolver package, manages the resolver configuration
file and then starts the associated resolver service.

### `resolver.check`

This state checks that the minion has actually enabled this formula either in the parameters/default.yaml or in pillar. 
This ensures that a formula doesn't get mistakenly applied to the wrong minion when applying states at the command line.
It should be included both in the formula's 'init.sls' as well as at the top of every state in the formula.

- For 'common' formulas that get applied everywhere, set the default (defaults.yaml  or parameters ) to 'True' and use 'False' in pillar (or role or minion-specific parameters) 
- For role-specific formulas, set the default to 'False' and use 'True' in pillar (or role or minion-specific parameters)
### `resolver.package`

This state will install the resolver package only.

### `resolver.config`

This state will configure the resolver service and has a dependency on
`resolver.install` via include list.

### `resolver.clean`

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the `resolver` meta-state
in reverse order, i.e. stops the service, removes the configuration file
and then uninstalls the package.

### `resolver.config.clean`

This state will remove the configuration of the resolver service and has
a dependency on `resolver.service.clean` via include list.

### `resolver.package.clean`

This state will remove the resolver package and has a depency on
`resolver.config.clean` via include list.

Testing
-------

Linux testing is done with `kitchen-salt`.

### Requirements

-   Ruby
-   Docker

``` {.sourceCode .bash}
$ gem install bundler
$ bundle install
$ bin/kitchen test [platform]
```

Where `[platform]` is the platform name defined in `kitchen.yml`, e.g.
`debian-9-2019-2-py3`.

### `bin/kitchen converge`

Creates the docker instance and runs the `resolver` main state, ready
for testing.

### `bin/kitchen verify`

Runs the `inspec` tests on the actual instance.

### `bin/kitchen destroy`

Removes the docker instance.

### `bin/kitchen test`

Runs all of the stages above in one go: i.e. `destroy` + `converge` +
`verify` + `destroy`.

### `bin/kitchen login`

Gives you SSH access to the instance for manual testing.
