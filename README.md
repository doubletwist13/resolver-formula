TEMPLATE-formula {#readme}
================

[![Travis CI Build Status](https://travis-ci.com/saltstack-formulas/TEMPLATE-formula.svg?branch=master)](https://travis-ci.com/saltstack-formulas/TEMPLATE-formula)
[![Semantic Release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

A SaltStack formula that is empty. It has dummy content to help with a
quick start on a new formula and it serves as a style guide.

General notes
-------------

See the full [SaltStack Formulas installation and usage
instructions](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

If you are interested in writing or contributing to formulas, please pay
attention to the [Writing Formula
Section](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas).

If you want to use this formula, please pay attention to the `FORMULA`
file and/or `git tag`, which contains the currently released version.
This formula is versioned according to [Semantic
Versioning](http://semver.org/).

See [Formula Versioning
Section](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning)
for more details.

If you need (non-default) configuration, please refer to:

-   [how to configure the formula with map.jinja](map.jinja.rst)
-   the `pillar.example` file
-   the [Special notes](#special-notes) section

Contributing to this repo
-------------------------

### Commit messages

**Commit message formatting is significant!!**

Please see [How to
contribute](https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst)
for more details.

### pre-commit

[pre-commit](https://pre-commit.com/) is configured for this formula,
which you may optionally use to ease the steps involved in submitting
your changes. First install the `pre-commit` package manager using the
appropriate [method](https://pre-commit.com/#installation), then run
`bin/install-hooks` and now `pre-commit` will run automatically on each
`git commit`. :

    $ bin/install-hooks
    pre-commit installed at .git/hooks/pre-commit
    pre-commit installed at .git/hooks/commit-msg

Special notes
-------------

### Using this template

The easiest way to use this template formula as a base for a new formula
is to use GitHub\'s **Use this template** button to create a new
repository. For consistency with the rest of the formula ecosystem, name
your formula repository following the pattern `<formula theme>-formula`,
where `<formula theme>` consists of lower-case alphabetic characters,
numbers, \'-\' or \'\_\'.

In the rest of this example we\'ll use `example` as the
`<formula theme>`.

Follow these steps to complete the conversion from `template-formula` to
`example-formula`. :

    $ git clone git@github.com:YOUR-USERNAME/example-formula.git
    $ cd example-formula/
    $ bin/convert-formula.sh example
    $ git push --force

Alternatively, it\'s possible to clone `template-formula` into a new
repository and perform the conversion there. For example:

    $ git clone https://github.com/saltstack-formulas/template-formula example-formula
    $ cd example-formula/
    $ bin/convert-formula.sh example

To take advantage of
[semantic-release](https://github.com/semantic-release/semantic-release)
for automated changelog generation and release tagging, you will need a
GitHub [Personal Access
Token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
with at least the **public\_repo** scope.

In the Travis repository settings for your new repository, create an
[environment
variable](https://docs.travis-ci.com/user/environment-variables/#defining-variables-in-repository-settings)
named `GH_TOKEN` with the personal access token as value, restricted to
the `master` branch for security.

Note that this repository uses a
[CODEOWNERS](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners)
file to assign ownership to various parts of the formula. The conversion
process removes overall ownership, but you should consider assigning
ownership to yourself or your organisation when contributing your new
formula to the `saltstack-formulas` organisation.

Available states
----------------

::: {.contents local=""}
:::

### `TEMPLATE`

*Meta-state (This is a state that includes other states)*.

This installs the TEMPLATE package, manages the TEMPLATE configuration
file and then starts the associated TEMPLATE service.

### `TEMPLATE.check`

This state checks that the minion has actually enabled this formula either in the parameters/default.yaml or in pillar. 
This ensures that a formula doesn't get mistakenly applied to the wrong minion when applying states at the command line.
It should be included both in the formula's 'init.sls' as well as at the top of every state in the formula.

- For 'common' formulas that get applied everywhere, set the default (defaults.yaml  or parameters ) to 'True' and use 'False' in pillar (or role or minion-specific parameters) 
- For role-specific formulas, set the default to 'False' and use 'True' in pillar (or role or minion-specific parameters)
### `TEMPLATE.package`

This state will install the TEMPLATE package only.

### `TEMPLATE.config`

This state will configure the TEMPLATE service and has a dependency on
`TEMPLATE.install` via include list.

### `TEMPLATE.service`

This state will start the TEMPLATE service and has a dependency on
`TEMPLATE.config` via include list.

### `TEMPLATE.clean`

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the `TEMPLATE` meta-state
in reverse order, i.e. stops the service, removes the configuration file
and then uninstalls the package.

### `TEMPLATE.service.clean`

This state will stop the TEMPLATE service and disable it at boot time.

### `TEMPLATE.config.clean`

This state will remove the configuration of the TEMPLATE service and has
a dependency on `TEMPLATE.service.clean` via include list.

### `TEMPLATE.package.clean`

This state will remove the TEMPLATE package and has a depency on
`TEMPLATE.config.clean` via include list.

### `TEMPLATE.subcomponent`

*Meta-state (This is a state that includes other states)*.

This state installs a subcomponent configuration file before configuring
and starting the TEMPLATE service.

### `TEMPLATE.subcomponent.config`

This state will configure the TEMPLATE subcomponent and has a dependency
on `TEMPLATE.config` via include list.

### `TEMPLATE.subcomponent.config.clean`

This state will remove the configuration of the TEMPLATE subcomponent
and reload the TEMPLATE service by a dependency on
`TEMPLATE.service.running` via include list and `watch_in` requisite.

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

Creates the docker instance and runs the `TEMPLATE` main state, ready
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
