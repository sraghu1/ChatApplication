<%-- 
    Document   : Login
    Created on : Oct 4, 2014, 12:06:29 PM
    Author     : Sabarish
--%>

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  </head>

  <body>
       
      <div class="container-fluid">
      <h2>Chat Room Application</h2>
      <div class="container">
          <div class="jumbotron">
              <%if(request.getAttribute("pagefrom")==null||request==null||request.getAttribute("pagefrom").equals(0)){}else{%><div> <h3>Login Failed </h3></div><%}%>
              <form role="form" action="LoginContoller" method="post">
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" name="email" class="form-control" id="email" placeholder="Enter email" required="true">
        </div>
        <div class="form-group">
          <label for="pwd">Password:</label>
          <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Enter password" required="true">
        </div>
        <div class="checkbox">
          <label><input type="checkbox"> Remember me</label>
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
        <br>
      <label for="signup">Not a user yet?? Sign-up here :</label><a href="signup.jsp" >sign-up</a>
    </div>
    </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
  </body>
</html>

