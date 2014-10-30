Issues
======

A console application for github issues.

Free software: BSD license


Requirements
------------

* Elixir v1.0.0+


Quickstart
----------

Clone the repository:

    $ git clone https://github.com/s-m-i-t-a/issues.git
    $ cd issues

then get deps and compile

    $ mix do deps.get, compile

create executable and run application

    $ mix escript.build
    $ ./issues elixir-lang elixir 5

or print help

    $ ./issues help
