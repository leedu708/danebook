var newPost = "<%= j(render :partial => 'post', :locals => { :post => @new_post }) %>";

var $posts = $("div[data-content='posts']");

$(newPost).prependTo($posts).hide().slideDown(750);

$('#post_body').val('');