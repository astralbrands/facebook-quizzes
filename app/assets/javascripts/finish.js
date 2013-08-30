$(document).ready(function() {
  $(".get-started").hide()
  $.ajaxSetup({ cache: true });
  $.getScript('//connect.facebook.net/en_US/all.js', function(){
    FB.init({
      appId: '221927934631179',
      channelUrl: '//yourapp.com/channel.html',
    });
  });
  $("#share-link").click(share)
});

share = function() {
	window.open(
      'https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 
      'facebook-share-dialog', 
      'width=626,height=436');
	return false
}