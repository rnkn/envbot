# envbot

I wanted a shell script that would allow directory-specifc environment
variables with a simple `.env` file in the directory, hence envbot.

## Installation

Source this script from your `.bash_profile`.

The format of `.env` file is as you'd expect, and allows for parameter
expansion:
~~~
ENVIRONMENT_VAR=value
ENVIRONMENT_VAR2="$PWD/value.txt"
~~~

## Todo

- [ ] walk up directory structure
