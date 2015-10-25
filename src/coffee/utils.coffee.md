
# Overview

Miscellaneous reusable stuff.

# Functions

## hashString(str)

Simple MD5 hash courtesy of [StackOverflow](http://stackoverflow.com/a/15710692)

**Returns** The hash.

    hashString = (str) ->
      reducer = (a,b) ->
        a=((a<<5)-a)+b.charCodeAt(0)
        a && a
      str.split('').reduce reducer, 0

# Exports

    exports =
      hashString: hashString

    if typeof module != 'undefined'
      module.exports = exports

    if angular
      angular.module('fkls').factory 'util', ->
        return exports
