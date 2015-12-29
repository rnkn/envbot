# envbot

envbot is a Bash script that, upon changing directory, looks for an
`.env` file in the current working directory and parent directories and
sets environment variables accordingly.

Existing environment variables are cached and reset when changing to
another directory.

An `.env` file in a lower directory takes precedence over one in a
higher directory.

## Installation

Source this script from your `.bash_profile` or `.bashrc`.

The format of `.env` file is as you'd expect, and allows for parameter
expansion:
~~~
ENVIRONMENT_VAR=value
ENVIRONMENT_VAR2="$PWD/value.txt"
~~~

To enable feedback when environment variables are changed, uncomment
the following:
~~~
# printf "envbot: Set %s=%s\n" "$_name" "$_value"
~~~

## Todo

- [X] walk up directory structure
- [ ] unset prior variables?
- [X] write proper README
