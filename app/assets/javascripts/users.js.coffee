initialize = ->
  'use strict'
  $('#sidebar').hide()
  $('#separator').hide()
  $('#clearer').hide()

$(document).ready initialize
$(document).on "page:load", initialize