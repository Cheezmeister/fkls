
# Overview

Miscellaneous stuff.

# Functions

## hashString(str)

Simple MD5 hash courtesy of [StackOverflow](http://stackoverflow.com/a/15710692)

**Returns** The hash of the input string

    hashString = (str) ->
      reducer = (a,b) ->
        a = ((a << 5) - a) + b.charCodeAt(0)
        a && a
      str.split('').reduce reducer, 0

# Exports

    exports =
      hashString: hashString

If using a node-style module system, set `module.exports`

    if typeof module != 'undefined'
      module.exports = exports

If using angular's DI, perform its incantation.

    if typeof angular != 'undefined'
      angular.module('fkls').service 'util', ->
        return exports
