$(document).ready(function() {
  $(".get-started").hide()
  $.ajaxSetup({ cache: true });
  $.getScript('//connect.facebook.net/en_US/all.js', function(){
    FB.init({
      appId: '221927934631179',
      channelUrl: '//yourapp.com/channel.html',
    });     
    $('#loginbutton,#feedbutton').removeAttr('disabled');
    FB.login(page_liked, { scope: 'user_likes' });
    FB.XFBML.parse();
    FB.Event.subscribe('edge.create', allow_continue)
  });
});

allow_continue = function(response) {
	$(".like-box").hide()
	$(".get-started").show()
}

page_liked = function() { 
	FB.api('/me/likes/44692365354', 
	function(response){
		if (response.data[0] != null) { 
			allow_continue(); 
		} else { 
			return null; 
		}
	})
};
