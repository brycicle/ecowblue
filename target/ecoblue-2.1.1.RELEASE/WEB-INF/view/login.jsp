
<%
    String errorMsg = (String) request.getAttribute("error");
%>

<!doctype html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	
	<link href="/css/ecoblue.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-3">
    <div class="row justify-content-center mt-5">
        <div class="card col-5 shadow p-3 mb-5 login rounded">
            <h3 class="card-title text-center">Ecoblue</h3>
            <%if(errorMsg!=null){ %>
                <div class="alert alert-danger" role="alert">
                    <%=errorMsg%>
                </div>
            <%}%>
            <div class="card-body">
                <form action="/login" method="POST">
                    <label>Email Address</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text transparent"><i class="fas fa-user white"></i></span>
                        </div>
                        <input type="text" class="form-control transparent-field" placeholder="Email" name="email" id="email">
                    </div>
                    <label>Password</label>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text transparent"><i class="fas fa-lock white"></i></span>
                        </div>
                        <input type="password" class="form-control transparent-field" placeholder="Password" name="password" id="password">
                    </div>
                    <button type="submit" class="btn btn-outline-primary btn-block login-btn mt-1">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>