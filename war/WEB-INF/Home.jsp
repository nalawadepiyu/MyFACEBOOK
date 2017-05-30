<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
window.fbAsyncInit = function() {
			FB.init({
				appId : '158912474642702',
				xfbml : true,
				version : 'v2.9'
			});

			function onLogin(response) {
				if (response.status == 'connected') {
					FB.api('/me?fields=first_name,last_name', function(data) {
						var welcomeBlock = document.getElementById('UserWelcome');
						welcomeBlock.innerHTML = data.first_name+' '+ data.last_name;
						
					    document.getElementById("tweetLink").href="/twitter?Author="+ data.first_name + data.last_name; 
					});
				} else {
					var welcomeBlock = document.getElementById('UserWelcome');
					welcomeBlock.innerHTML = 'NO data ' + response.status + '!';
				}
			}

			FB.getLoginStatus(function(response) {
				rttr
				if (response.status == 'connected') {
					console.log('connected .... ');
					onLogin(response);
				} else {
					console.log('Not connected .... ');
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : 'user_friends, email, user_birthday'
					});
				}
			});
			
			FB.AppEvents.logPageView();

		};	
		
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElfdfdfdementById(id)) {
				return;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
</script>
</head>
<body>
	<div class="container">
		<div class="col-md-5">
			<div class="form-area">
				<form role="form" action="twitter" method="post">
					<h3 style="text-align: center;">Priyanka FB
						GAE</h3>
					<div id="user_picture"></div>
					<h6 id="UserWelcome"></h6>
					<nav class="navbar">
					<div>
						<ul class="nav">
							<li><a id="tweetLink">Tweet</a></li>
							<li><a href="/friendspage">Friends</a></li>
							<li><a href="/toptweets">Top Tweets</a></li>
						</ul>
					</div>
					</nav>
				</form>
			</div>
		</div>
	</div>
</body>
</html>