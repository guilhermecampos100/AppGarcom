<!DOCTYPE html>
<html lang="en">
<%
'declare the variables 
Dim Connection
Dim ConnString
Dim Recordset
Dim SQL
'define the connection string, specify database driver
ConnString="Provider=SQLOLEDB;Data Source=SQL5013.Smarterasp.net;Initial Catalog=DB_9CAA15_guilhermecampos;User Id=DB_9CAA15_guilhermecampos_admin;Password=jaburu99;"

'create an instance of the ADO connection and recordset objects
Set Connection = Server.CreateObject("ADODB.Connection")
Set Recordset = Server.CreateObject("ADODB.Recordset")
'Open the connection to the database
Connection.Open ConnString

login = request.form("login")

sql = "select * from garcom where token = '" & login & "'"
Recordset.Open SQL,Connection
if not Recordset.eof then
	Recordset.close
	Connection.Close
	set Recordset = nothing
	set connection = nothing
	response.redirect "painelgarcom.html?token=" & login
end if


Recordset.close
mensagem = ""
if login <> "" then
	sql = "select senha from restaurante where login = '" & login & "'"
	Recordset.Open SQL,Connection
	if recordset.eof then
		mensagem = "Login não encontrado"
	else
		if recordset("senha") <> request.form("senha") then	
			mensagem = "Senha incorreta"
		else
			session("login") = login
			response.redirect "painel.asp"
		end if
	end if
end if
	


%>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>BarCzar Admin - Login</title>

    <!-- Bootstrap Core CSS -->
    <link href="../bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">insira login e senha ou somente o token</h3>
                    </div>
                    <div class="panel-body">
                        <form method="post" action="login.asp">
                            <fieldset>
                                <div class="form-group">
									<font color="red"><%= mensagem %></font>
                                    <input class="form-control" placeholder="login ou token" name="login" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="senha" name="senha" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="Remember Me">Lembrar de mim
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <button class="btn btn-lg btn-success btn-block">Login</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="../bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>

</body>

</html>
