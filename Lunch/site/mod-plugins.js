//the whole point of this file is to disable push state on jquery mobile (just to use swipe !?!)
//http://stackoverflow.com/questions/11955349/force-jquery-mobile-to-update-hash-instead-of-url-for-ajax-pages
$(document).bind("mobileinit", function(){
  $.mobile.pushStateEnabled = false;
});