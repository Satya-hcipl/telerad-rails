initialize = ->
  'use strict'
  $('#sidebar').hide()
  $('#separator').hide()
  $('#clearer').hide()
  Metronic.init()
  Layout.init()
  Login.init()
  QuickSidebar.init()
  ComponentsPickers.init()
  Demo.init()

$(document).ready initialize
$(document).on "page:load", initialize