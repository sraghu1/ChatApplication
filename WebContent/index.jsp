<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>UTA Chatroom Application</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Sabarish">

<script src="resource/js/jquery-1.10.2.min.js"></script>

<!-- Le styles -->
<link href="./resource/css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #f5f5f5;
}

.form-signin {
	max-width: 300px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
}

.form-signin .form-signin-heading,.form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin input[type="text"],.form-signin input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 7px 9px;
}

#chatroom {
	font-size: 16px;
	height: 40px;
	line-height: 40px;
	width: 300px;
}

.received {
	width: 160px;
	font-size: 10px;
}
</style>
<link href="./resource/css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="./resource/js/html5shiv.js"></script>
    <![endif]-->

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="./resource/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="./resource/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="./resource/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="./resource/ico/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="./resource/ico/favicon.png">
<script>
	var wsocket;
	var serviceLocation = "ws://" + document.location.host + "/ChatApplication/chat/";
	var $nickName;
	var $message;
	var $chatWindow;
	var room = '';
        var users;
//listen to message receipt in client from server and append to chatwindow table
	function onMessageReceived(evt) {
		var msg = JSON.parse(evt.data); // native API
	//$chatWindow.append(msg.sender+'just joined');	
        var $messageLine = $('<tr><td class="received">' + msg.received
				+ '</td><td class="user label label-info">' + msg.sender
				+ '</td><td class="message badge">' + msg.message
				+ '</td></tr>');
		$chatWindow.append($messageLine);
	}
        //send the message to websocket in chatMessage format 
	function sendMessage() {
		var msg = '{"message":"' + $message.val() + '", "sender":"'
				+ $nickName.val() + '", "received":""}';
		wsocket.send(msg);
                //alert(document.location.host);
		$message.val('').focus();
	}
//create new websocket and listen to messages. OnMessage call onMessage counterpart in chat end point
	function connectToChatserver() {
		 room= $('#chatroomopt option:selected').val();
                 //alert(room);
                nickname=$('#nickname').val();
		wsocket = new WebSocket(serviceLocation + room +"&"+ nickname);
                //wsocket.send("new user");
		wsocket.onmessage = onMessageReceived;
	
    }
//CLOSE THE SOCKET I.E; call OnClose method in endpoint and show chatroom selection
	function leaveRoom() {
            
		wsocket.close();//CLOSE THE SOCKET I.E; call OnClose method in endpoint
		$chatWindow.empty(); 
		$('.chat-wrapper').hide();
		$('.chat-signin').show();
		$nickName.focus();
	}
//THis is executed first when doc is loaded
	$(document).ready(function() {
		$nickName = $('#nickname');
		$message = $('#message');
		$chatWindow = $('#response');
		$('.chat-wrapper').hide();
		$nickName.focus();
		//when enterroom button is pressed populate divs and call connecttochatserver method above
		$('#enterRoom').click(function(evt) {
			evt.preventDefault();
			connectToChatserver();
			$('.chat-wrapper h2').text('Chat session of # '+$nickName.val() + "@" + room);
			$('.chat-signin').hide();
			$('.chat-wrapper').show();
			$message.focus();
		});
                //when do-chat form is submitted, call sendMessage() 
		$('#do-chat').submit(function(evt) {
			evt.preventDefault();
			sendMessage();
		});
		
		$('#leave-room').click(function(){
			leaveRoom();
		});
                //send and receive ajax request to and from server to get users every second
                setInterval(function() {               // Locate HTML DOM element with ID "somebutton" and assign the following function to its "click" event...
                    $.get('GetUsers',{room: $('#chatroomopt option:selected').val()}, function(responseText) { // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
                    $users=   $('#users');
                    
                    $('#users').text(responseText);         // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
                    });
                },1000);
                //send and receive ajax request to and from server to get rooms 
                var prevObj;
                setInterval(function() {               // Locate HTML DOM element with ID "somebutton" and assign the following function to its "click" event...
                    $.get('GetRooms', function(responseText) { // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
                        if(prevObj!=responseText){
                    	$('#chatroomopt').html(responseText);         // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
                        prevObj=responseText;
                        }
                        });
                },1000);
	}); 
</script>
</head>

<body>

	<div class="container chat-signin">
		<form class="form-signin">
			<h2 class="form-signin-heading">Chat Lobby</h2>
                        <label for="nickname">Nickname</label> <input type="text" class="input-block-level" value="<%= session.getAttribute("nickname")%>" id="nickname" readonly="true">
			<div class="btn-group">
				<label for="chatroom">Chatroom</label> <select size="1"
					id="chatroomopt">
				</select>
			</div>
			<button class="btn btn-large btn-primary" type="submit"
				id="enterRoom">Go and Chat</button>
                </form>
                <div class="container"><br/>New ChatRoom? <br/><form id='new-chatroom' action="CreateRoom" method="post" class="sign-in"><label for="cr_roomname">Room Name: </label> <input type="text" id="cr_roomname" name="cr_roomname"><button type="submit" class="btn btn-small btn-primary">Create new Room</button></form></div></form><a href='LogoutController'>Log out </a>
	</div>
	<!-- /container -->

	<div class="container chat-wrapper">
		<form id="do-chat">
			<h2 class="alert alert-success"></h2>
			<table id="response" class="table table-bordered"></table>
			<fieldset>
				<legend>Enter your message..</legend>
				<div class="controls">
					<input type="text" class="input-block-level" placeholder="Your message..." id="message" style="height:60px"/>
					<input type="submit" class="btn btn-large btn-block btn-primary"
						value="Send message" />
					<button class="btn btn-large btn-block" type="button" id="leave-room">Leave
						room</button>
				</div>
                                <div id='users'></div>
			</fieldset>
		</form>
	</div>
</body>
</html>