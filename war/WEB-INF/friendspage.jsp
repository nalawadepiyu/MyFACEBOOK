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
</head>

<body id="body">

	<div class="container">
		<div class="col-md-5">
			<div class="form-area">
				<form id="fb_Form" role="form" action="twitter" method="post">
					<h3 style="text-align: center;">Priyanka
						Twitter Messages</h3>
					<div id="user_picture"></div>
					<h6 id="UserWelcome"></h6>
					<nav class="navbar">
						<div>
							<ul class="nav">
								<li><a id ="tweetlink">New Tweet</a></li>
								<li><a href="/friendspage">Friends Tweets</a></li>
								<li><a href="/toptweets">Top Tweets</a></li>
							</ul>
						</div>
					</nav>
				</form>
			</div>
		</div>
	</div>

	<input type="hidden" id="author" name="author" value=">">
	<br>

	<script>
		var usrtwts = "${usrtwts}";
		usrtwtsArray = usrtwts.split("-----")
		for (var i = 0; i < usrtwtsArray.length - 1; i++) {
			
		}

		window.fbAsyncInit = function() {
			FB.init({
				appId : "158912474642702",
				xfbml : true,
				version : "v2.9"
			});

			function onLogin(response) {
				if (response.status == "connected") {
					FB
							.api(
									"/me?fields=first_name,last_name,picture",
									function(data) {
										var image = document
												.createElement("img");
										var imageParent = document
												.getElementById("fb_Form");
										image.id = "Owner Image";
										image.className = "class";
										image.src = data.picture.data.url;
										imageParent.appendChild(image);

										var t = document.createTextNode(" "
												+ data.first_name
												+ data.last_name);
										imageParent.appendChild(t);

										linebreak = document
												.createElement("br");
										imageParent.appendChild(linebreak);

										if (usrtwts.includes(data.first_name
												+ data.last_name)) {
											for (var i = 0; i < usrtwtsArray.length - 1; i++) {
												if (usrtwtsArray[i]
														.includes(data.first_name
																+ data.last_name)) {
													var a = document
															.createElement("a");
													var msg = document
															.createTextNode(usrtwtsArray[i]
																	.split("--")[1]);
													msg.textIndent = "100px";
													a.appendChild(msg)
													a.className = "form-control";
													a.title = msg;
													a.href = "https://facebookgae-169210.appspot.com/tweetinfo?id="
															+ usrtwtsArray[i].split("--")[0];
													a.target = "_blank";
													imageParent
															.appendChild(document
																	.createTextNode("\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"));
													imageParent.appendChild(a);													
												}
											}
											lb = document.createElement("br");
											imageParent.appendChild(lb);
										}

										var welcomeBlock = document
												.getElementById("UserWelcome");
										welcomeBlock.innerHTML =
												data.first_name + " "
												+ data.last_name;
										document.getElementById("tweetLink").href="/twitter?Author="+data.first_name + data.last_name;
										var sendName = document
												.getElementById("author")
										if (sendName) {
											sendName.value = data.first_name
													+ data.last_name;
										} else {
											console.log("The sender is ok ");
										}
									});

					FB.api(
									"/me/friends?fields=first_name,last_name,picture",
									function(data) {
										//console.log(data);

										for ( var i in data.data) {
											var image = document
													.createElement("img");
											var imageParent = document
													.getElementById("fb_Form");
											image.id = "id" + i;
											image.className = "class";
											image.src = data.data[i].picture.data.url;
											imageParent.appendChild(image);

											var t = document.createTextNode(" "
													+ data.data[i].first_name
													+ data.data[i].last_name);
											imageParent.appendChild(t);

											linebreak = document
													.createElement("br");
											imageParent.appendChild(linebreak);

											if (usrtwts
													.includes(data.data[i].first_name
															+ data.data[i].last_name)) {
												for (var k = 0; k < usrtwtsArray.length - 1; k++) {
													if (usrtwtsArray[k]
															.includes(data.data[i].first_name
																	+ data.data[i].last_name)) {
														var a = document
																.createElement("a");
														var msg = document
																.createTextNode(usrtwtsArray[k]
																		.split("--")[1]);
														msg.textIndent = "100px";
														a.appendChild(msg)
														a.className = "form-control";
														a.title = msg;
														a.href = "https://facebookgae-169210.appspot.com/tweetinfo?id="
																+ usrtwtsArray[k]
																		.split("--")[0];
														a.target = "_blank";
														imageParent
																.appendChild(document
																		.createTextNode("\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"));
														imageParent
																.appendChild(a);												
													}
												}
												lb = document.createElement("br");
												imageParent.appendChild(lb);
											}
										}
									}, {
										scope : "user_friends"
									});
				} else {
					var welcomeBlock = document.getElementById("UserWelcome");
					welcomeBlock.innerHTML = "No data " + response.status
							+ "!";
				}
			}

			FB.getLoginStatus(function(response) {
				
			

				if (response.status == "connected") {
					console.log("connected .... ");
					onLogin(response);
				} else {
					console.log("Not connected .... ");
					FB.login(function(response) {
						onLogin(response);
					}, {
						scope : "user_friends, email, user_birthday"
					});
				}
			});
			
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