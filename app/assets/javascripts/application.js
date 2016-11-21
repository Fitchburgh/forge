// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function () {
  var getCalls = $('.getCalls');
  var postCalls = $('.postCalls');
  var patchCalls = $('.patchCalls');
  var putCalls = $('.putCalls');
  var deleteCalls = $('.deleteCalls');

  var getCallsBtn = $('.getCallsBtn');
  var postCallsBtn = $('.postCallsBtn');
  var patchCallsBtn = $('.patchCallsBtn');
  var putCallsBtn = $('.putCallsBtn');
  var deleteCallsBtn = $('.deleteCallsBtn');

  var hideGetBtn = $('.hideGetBtn');
  var hidePostBtn = $('.hidePostBtn');
  var hidePatchBtn = $('.hidePatchBtn');
  var hidePutBtn = $('.hidePutBtn');
  var hideDeleteBtn = $('.hideDeleteBtn');

  var apiBtn = $('.apiBtn');
  var logoutBtn = $('.logoutBtn');
  var apiLoginBtn = $('.apiLoginBtn');

  apiBtn.click(function(){
    window.location.href="https://forge-api.herokuapp.com/admins/new";
  });

  apiLoginBtn.click(function(){
    window.location.href="https://forge-api.herokuapp.com/login";
  });

  logoutBtn.click(function(){
    window.location.href="https://forge-api.herokuapp.com/sessions/destroy";
  });

  getCallsBtn.click(function(){
    getCalls.fadeIn(750);
  });

  postCallsBtn.click(function(){
    postCalls.fadeIn(750);
  });

  patchCallsBtn.click(function(){
    patchCalls.fadeIn(750);
  });

  putCallsBtn.click(function(){
    putCalls.fadeIn(750);
  });

  deleteCallsBtn.click(function(){
    deleteCalls.fadeIn(750);
  });

  hideGetBtn.click(function(){
    getCalls.fadeOut(750);
  });

  hidePostBtn.click(function(){
    postCalls.fadeOut(750);
  });

  hidePatchBtn.click(function(){
    patchCalls.fadeOut(750);
  });

  hidePutBtn.click(function(){
    putCalls.fadeOut(750);
  });

  hideDeleteBtn.click(function(){
    deleteCalls.fadeOut(750);
  });
});
