<%-- 
    Document   : signup
    Created on : Sep 26, 2014, 6:43:59 PM
    Author     : Sabarish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

        <title>Signup</title>
        <script>
            function validate()
{
//alert(document.getElementById("name_signup").value.length>15);
        if(document.getElementById("name_signup").value.length>15 )
	{
	document.getElementById("validate_error").innerHTML="Username cannot be > 15 chars";
	//document.Signup.validate_error.focus() ;
        return false;
	}
        
	if(document.getElementById("pwd1").value.length>15 )
	{
	document.getElementById("validate_error.innerHTML").innerHTML="Password is Mandatory";
	
    return false;
	}
	
	if(document.getElementById("email_signup")==''||document.getElementById("email_signup")==null )
	{
	document.validate_error.innerHTML("email is Mandatory");
	document.Signup.email.focus() ;
    return false;
	}
	
	
}
function revalidate()
{
	if(document.getElementById("pwd1").value!=document.getElementById("pwd2").value)	
	{
		document.getElementById("validate_error").innerHTML="Passwords do Not match<br/>";
		return false;
	}
        else
        {
            document.getElementById("validate_error").innerHTML="<br/>";
            return true;
        }
}
</script>
    </head>
    <body>
        <div class="container-fluid">
        <div class="header">
            <center><h2>Chat Room App</h2></center>
        </div>
      <div class="container">  
    <div class="center jumbotron">    
        <h2>Sign Up!</h2> 
        <%if(request.getAttribute("pagefrom")==null||request.getAttribute("pagefrom").equals(0)){}else{%><div> User already exists. </div><%}%>
        <form role="signupform" action="SignupController" method="post" onsubmit="validate(this);revalidate(this);" >
        <div class="form-group">
            <span id="validate_error"></span>
          <label for="email">Email:</label>
          <input type="email" class="form-control" id="email_signup" name="email_signup" placeholder="Enter email" required="true">
        </div>
        <div class="form-group">
          <label for="name">Nickname:</label>
          <input type="text" class="form-control" id="name_signup" name="name_signup" placeholder="Enter your nickname" required="true">
        </div>
         <div class="form-group">
          <label for="pwd1">Password:</label>
          <input type="password" class="form-control" name="pwd1" id="pwd1" placeholder="Enter password" required="true">
        </div>
            <div class="form-group">
                <label for="pwd2">Retype Password:</label>
                <input type="password" class="form-control" name="pwd2" id="pwd2" placeholder="Retype password" onblur="revalidate(this);">
            </div>
            <button type="submit" class="btn btn-default" onclick="revalidate(this);">Signup</button>
        </form>
        </div>
      </div>
        </div>
        </body>
</html>
