_ = require 'angular'
_ = require 'jquery'
_ = require './hello-world-directive'
_ = require './notepad'

m = angular.module 'directives', [
  'helloWorld1'
  'notepad'
]