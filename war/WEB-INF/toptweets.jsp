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
<style type="text/css">
ul {
		    list-style-type: none;
		    margin: 0;
		    padding: 0;
		    overflow: hidden;
		    background-color: red;
		}
		
		li {
		    float: left;
		}
</style>
</head>

<body>
	<div class="container">
		<div class="col-md-5">
			<div class="form-area">
				<form id="eleForm" role="form" action="twitter" method="post"
					style="width: 150%;">
					<h3 style="margin-bottom: 25px; text-align: center;">Priyanka Top
						Twitter</h3>
					<div id="user_picture"></div>
					<h6 id="UserWelcome"></h6>
					<nav class="navbar">
						<div>
							<ul class="nav">
								<li><a id="tweetlink">New Tweet</a></li>
								<li><a href="/friendspage">Friends Tweets</a></li>
								<li><a href="/toptweets">Top Tweets</a></li>
							</ul>
						</div>
					</nav>
					<h5 id="txt"></h5>
				</form>
			</div>
		</div>
	</div>
	<input type="hidden" id="author" name="author" value=">">


	<script>
		var usrtwts = "${usrtwts}";
		console.log(usrtwts);
		usrtwts = usrtwts.split("-----")
		for (var i = 0; i < usrtwts.length-1; i++) {
			console.log(usrtwts[i]);
			console.log(document.getElementById("txt").innerHTML);
			document.getElementById("txt").innerHTML = document.getElementById("txt").innerHTML +usrtwts[i].split("--")[0]+"  ("+usrtwts[i].split("--")[1]+"Visits)<br>";
		}		
	 	window.fbAsyncInit = function() {
			FB.init({
				appId : "158912474642702",
				xfbml : true,
				version : "v2.9"
			});

			function onLogin(response) {
				if (response.status == "connected") {
					FB.api("/me?fields=first_name,last_name", function(data) {
						
						var welcomeBlock = document.getElementById("User_Welcome");
						welcomeBlock.innerHTML = "Hello, " + data.first_name+" "+ data.last_name + "!"+"<br/>"+"Welcome to the Application";
					    document.getElementById("tweetlink").href="/twitter?Author="+data.first_name + data.last_name; 
						var sndName= document.getElementById("author")
						if (sndName){
							console.log("The sender is fine ");
							sndName.value = data.first_name+" "+ data.last_name;
						}else{
							console.log("The sender is fine ");
						}
					});
				} else {
					var welcomeBlock = document.getElementById("fb-welcome");
					welcomeBlock.innerHTML = "No data " + response.status + "!";
				}
			}
			
			FB.getLoginStatus(function(response) {								
				if (response.status == "connected") {					
					onLogin(response);
				} else {					
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : "user_friends, email, user_birthday"
					});
				}
			});

			console.log("logPageView .... ");
			FB.AppEvents.logPageView();

		};

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, "script", "facebook-jssdk"));

	</script>
</body>
</html>