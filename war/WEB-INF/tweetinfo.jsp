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
<title>View Tweet</title>
</head>
<body>

	<div class="container">
		<div class="col-md-5">
			<div class="form-area">
				<form role="form" action="twitter" method="post">
					<div id="user_picture"></div>
					<h6 id="UserWelcome"></h6>
					<div class="container">
						<div class="col-md-5">
							<div class="form-area">
								<h3 style=" text-align: center;">Priyanka FB GAE
									</h3>
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
								<div class="form-group">
									Tweet:
									<p id="message" class="form-control"></p>
								</div>
								<div class="form-group">
									Tweet Id:
									<p id="ID" class="form-control"></p>
								</div>
								<div class="form-group">
									Created By:
									<p id="author" class="form-control"></p>
								</div>
								<div class="form-group">
									Created On:
									<p id="createdAt" class="form-control"></p>
								</div>
								<div class="form-group">
									Visited Count:
									<p id="visitedCount" class="form-control"></p>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		document.getElementById("ID").innerHTML = "${ID}"
		document.getElementById("author").innerHTML = "${author}"
		document.getElementById("message").innerHTML = "${message}"
		document.getElementById("createdAt").innerHTML = "${createdAt}"
		document.getElementById("visitedCount").innerHTML = "${visitedCount}"

		function onLogin(response) {
			if (response.status == "connected") {
				FB
						.api(
								"/me?fields=first_name,last_name",
								function(data) {
									var welcomeBlock = document
											.getElementById("UserWelcome");
									welcomeBlock.innerHTML = "Hello, "
											+ data.first_name + " "
											+ data.last_name ;
									document.getElementById("tweetLink").href = "/twitter?Author="
											data.first_name + data.last_name;
									var sendName = document
											.getElementById("author")
									if (sendName) {
										console.log("The sender is fine ");
										sendName.value = data.first_name + " "
												+ data.last_name;
									} else {
										console.log("The sender is fine ");
									}
								});
			} else {
				var welcomeBlock = document.getElementById("fb-welcome");
				welcomeBlock.innerHTML = " No data " + response.status
						+ "!";
			}
		}
	</script>
</body>
</html>