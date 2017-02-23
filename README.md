[![Build Status](https://travis-ci.org/mumuki/mumuki-qsim-runner.svg?branch=master)](https://travis-ci.org/mumuki/mumuki-qsim-runner)
[![Code Climate](https://codeclimate.com/github/mumuki/mumuki-qsim-server/badges/gpa.svg)](https://codeclimate.com/github/mumuki/mumuki-qsim-server)
[![Test Coverage](https://codeclimate.com/github/mumuki/mumuki-qsim-server/badges/coverage.svg)](https://codeclimate.com/github/mumuki/mumuki-qsim-server)


# Runner

It performs equality tests on one or many records after the execution of a given Qsim program.

~~~ruby
bridge = Mumukit::Bridge::Runner.new('http://localhost:4568')
bridge.run_tests!(test: tests, extra: extra, content: program)
~~~

Extras are any type of additional code needed to run the exercise.

Tests must be defined in a YAML-based string, following this structure.
~~~javascript
{  examples: [test1, test2] }
~~~

Each individual test consists of a name, preconditions and postconditions.

Preconditions are values we want our Qsim environment to start with, while postconditions
are the expectations on post-execution record's values.

In the example given below the program sets `R0 = AAAA` and `R1 = BBBB`, and expects
that its final value is `FFFF`. Records, flags, special records and memory addresses can be set.
~~~javascript
test1 = {
    name: 'R0 should remain unchanged',
    preconditions: {
        R0: 'AAAA',
        R1: 'BBBB'
    },
    postconditions: {
        R0: 'FFFF'
    }
}
~~~
Keep in mind that preconditions are optional. 
If they are not specified, program defaults with be set.

##Full test example
~~~ruby
"examples:
      - name: 'Multiplying by two doesn't change R1'        
        postconditions:
          equal:
            R1: '0000'
      - name: 'R2 is doubled'
        preconditions:
         R1: '0001'
         R2: '0003'
        postconditions:
          equal:
            R2: '0006'"
~~~

Full examples can be found in the [integration suite](https://github.com/mumuki/mumuki-qsim-runner/blob/master/spec/integration_spec.rb) or [programs folder](https://github.com/mumuki/mumuki-qsim-runner/tree/master/spec/data) 


# Install the server

## Clone the project

```
git clone https://github.com/mumuki/mumuki-qsim-server 
cd mumuki-qsim-server
```

## Install Ruby

```bash
rbenv install 2.3.1
rbenv rehash
gem install bundler
```

## Install Dependencies

```bash
bundle install
```

# Run the server

```bash
RACK_ENV=development bundle exec rackup -p 4567
```



