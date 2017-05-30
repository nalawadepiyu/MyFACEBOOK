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
				<form role="form" action="twitter" method="post"
					>
					<h3 style="color:blue; text-align: center;">My Facebook GAE App
					</h3>
					<img id="user_picture"></img>
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
					<div class="form-group">
						<input type="text" class="form-control" id="txtpostTwt"
							name="txtpostTwt" placeholder="Enter Tweet" ><br>
						<input type="checkbox" name="fb" id="checkFbPost" value="fb_Post"> Post on FB <br>  						
						<button type="submit" id="btnPost" onClick="checkForPostedMsg()" >Save To DB</button>
						<br>
					</div>
					<select name="selectedTweets" id="selectedTweets" size="5" style="overflow: scroll;"></select><br />

					<input type="hidden" id="Author" name="Author"> <input
						type="hidden" id="sendName" name="sendName" value=">"><br>

					<div class="btn-group" style="align-items: center;">
						<button type="button"
							onclick="viewTweetInformation();">Display Information</button>
							<br/>
							<br/>
						<button type="button"
							onclick="postTweetToTimeLine()">Post to FB Timeline</button>
							<br/>
							<br/>
						<button type="button" 
							onclick="SendMessageToFriend()">Send Message To Friend</button>
							<br/>
							<br/>
						<button type="button"
							onclick="deleteTweet()">Delete</button>														
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
	console.log("${sendName}");
	var usrtwts = "${usrtwts}";	
	var myselect = document.getElementById("selectedTweets");
	usrtwts = usrtwts.split("-----")
	for (var i = 0; i < usrtwts.length-1; i++) {	
		var opt = document.createElement("option");
	    opt.value = usrtwts[i].split("--")[0];
	    opt.innerHTML = usrtwts[i].split("--")[1];
	    myselect.appendChild(opt);
	}

	window.fbAsyncInit = function() {
		FB.init({
			appId : "158912474642702",
			xfbml : true,
			version : "v2.9"
		});
	
		function onLogin(response) {
			if (response.status == "connected") {
				FB.api("/me?fields=first_name,last_name,picture", function(data) {
					var welcomeBlock = document.getElementById("UserWelcome");
					welcomeBlock.innerHTML = "First Name : " + data.first_name+"<br/>"+ "Last Name : "+ data.last_name ;					
					document.getElementById("Author").value = data.first_name + data.last_name;
					document.getElementById("user_picture").src = data.picture.data.url;
				});
			} else {
				var welcomeBlock = document.getElementById("UserWelcome");
				welcomeBlock.innerHTML = "No Data " + response.status + "!";
			}
		}
		FB.getLoginStatus(function(response) {
			console.log("getLoginStatus .... ");
			if (response.status == "connected") {
				console.log("connected .... ");
				onLogin(response);
			} 
			else {
				// Otherwise, show Login dialog first.
				console.log("Not connected .... ");
				FB.login(function(response) {onLogin(response);}, 
						{scope : "user_friends, email, user_birthday"
				});
			}
		});
		FB.AppEvents.logPageView();
	};

	function viewTweetInformation() {
	    window.open("https://facebookgae-169210.appspot.com/tweetinfo?id=" + myselect.options[myselect.selectedIndex].value 
	    		, "_blank", "toolbar=yes, location=yes, status=yes, menubar=yes, scrollbars=yes");
	}
	
	function postTweetToTimeLine() {			
		var linkToPost = "https://facebookgae-169210.appspot.com/tweetinfo?id=" + selectedTweets.options[selectedTweets.selectedIndex].value ;
	
		FB.login(function() {
					FB.api("/me/feed", "post", {
						message : linkToPost
					});					
		}, {scope : "publish_actions"});
	}
	
	function checkForPostedMsg(){
		if(document.getElementById('checkFbPost').checked == true){
			var linkToPost = document.getElementById("txtpostTwt").value;
			FB.login(function() {
				FB.api("/me/feed", "post", {
					message : linkToPost
				});					
			}, {scope : "publish_actions"});
		}		
	}
	
	function deleteTweet(){
		selectedTweets.options[selectedTweets.selectedIndex].remove();
	}
	//https://facebookgae-169210.appspot.com
	function SendMessageToFriend() {
		var linkToSend = "https://facebookgae-169210.appspot.com/tweetinfo?id=" + selectedTweets.options[selectedTweets.selectedIndex].value ;
		FB.ui({
			app_id : "158912474642702",
			method : "send",
			link : linkToSend,
		});
	}
	
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.asynk = true;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, "script", "facebook-jssdk"));
	</script>

</body>
</html>
