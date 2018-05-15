<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, dao.*, java.util.*,model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/estilo.css"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Atletismo</title>
</head>
<body>
<div class="head">
	<img class="esquerda"src="img/at.png"/>
	<img class="direita" src="img/at.png"/>
	<p class="mund"><marquee width="300" scrollamount="300" scrolldelay="300">Mundial:</marquee></p><input class="esq" type="text/css">
	<p class="even"><marquee width="300" scrollamount="300" scrolldelay="300">Evento:</marquee></p> <input class="dir" type="text/css"/>
</div>
	<script src="https://code.jquery.com/jquery-1.6.2.js" integrity="sha256-pXKSYZ0U64y9kjvenyjPmUrGarxI98l1t2kyj/M73ck=" crossorigin="anonymous"></script>
	<script text="text/javascript">
	</script>
<div class="topo">
<form method="post" action="./controlePesquisa">
	<label>FASE:</label>
	<select name="fase1">
		<option>INICIAL</option>
		<option>FINAL</option>
	</select>
	<label>PROVA:</label>
	<select name ="prova1">
		<%
				Lista provinha= new Lista();
				List<Prova> pro=provinha.ListaModalidade();
				for(Prova prova: pro){
			%>
				<option value="<%=prova.getProva()%>" style="width:150px;"><%=prova.getProva()%></option>
			<%
				}
			%>
	</select>
		<input id="buscar" name="cmd" type="submit" value="buscar"/>
</div>
<div class="contain">
		<%
			   List<Desempenho> prova = (List<Desempenho>)request.getAttribute("PROVA"); 
			   	if (prova != null && prova.size() > 0) { 
				%>
	<table class="blueTable"id="tabela">
		<thead>
		<tr>
		<th style="color:#000;">Código</th>
		<th style="color:#000;">Atleta</th>
		<th style="color:#000;">País</th>
		<th style="color:#000;">Resultado</th>
		</tr>
		</thead>
		<tbody>
		<tr>
		<% for (Desempenho de : prova) {  %>
		<td><%=de.getCodAtl() %></td>
		<td><%= de.getNome()%></td>
		<td><%=de.getPais() %></td>
		<td><%=de.getResultado()%></td>
		</tr>
		<% } %>
		</tbody>
	</table>
	<% } %>
		<% 
				List<Desempenho> d = (List<Desempenho>)request.getAttribute("DESEMPENHO"); 
			   	if (d != null && d.size() > 0) { 
				%>
				<table class="blueTable"id="tabela3">
					<style>
						#tabela,#tabela2{
							display:none;
						}
					</style>
					<thead>
					<tr>
					<th style="color:#000;">Code</th>
					<th style="color:#000;">Atleta</th>
					<th style="color:#000;">País</th>
					<th style="color:#000;">Resultado</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<% for (Desempenho des : d) {  %>
					<td><%=des.getCodAtl() %></td>
					<td><%= des.getNome()%></td>
					<td><%=des.getPais() %></td>
					<td><%=des.getResultado()%></td>
					</tr>
					<% } %>
					</tbody>
				</table>
				<% } %>
</div>
<div class="aside">
			<h3 align="center">Quero Pesquisar</h3>
			<table id="shame">
			<tr>
			<td>
				<label>PROVA:</label>
						<select class="posicao" id="prova" name="prova">
							<%
								Lista listaP= new Lista();
								List<Prova> pr=listaP.ListaModalidade();
								for(Prova p: pr){
							%>
								<option value="<%=p.getProva()%>" style="width:150px;"><%=p.getProva()%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
				<td>
						<label>BATERIA:</label>
						<select class="posicao" id="bateria" name="bateria">
							<option>1ºCiclo</option>
							<option>2ºCiclo</option>
							<option>3ºCiclo</option>
							<option>4ºCiclo</option>
							<option>5ºCiclo</option>
							<option>6ºCiclo</option>
						</select>
				</td>
				</tr>
				<tr>
				<td>
							<label>FASE:</label>
						<select class="posicao" id="fase" name="fase">
							<option value="INICIAL">INICIAL</option>
							<option value="FINAL">FINAL</option>
						</select>
				</td>
				</tr>
				<tr>
				<td>
					<input type="submit" id="ir" name="cmd" value="ir">
				</td>
				</tr>
			</table>
			</form>
</div>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#fase').change(function(){
			var val=$('#fase option:selected').val();
			if (val=="INICIAL"){
				$("#tabela2").css("display","none");
				$("#tabela3").css("display","none");
				$("#tabela").css("display","table");
			}else{
				$("#tabela").css("display","none");
				$("#tabela3").css("display","none");
				$("#tabela2").css("display","table");
			}
		});
	});
	</script>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#prova').change(function(){
			var ss=$('#prova option:selected').val();
			var length = $("#prova")[0].selectedIndex;
			if(length<7) {
					$('#bateria').html('<select id="bateria"><option>1ºCiclo</option><option>2ºCiclo</option><option>3ºCiclo</option><option>4ºCiclo</option><option>5ºCiclo</option><option>6ºCiclo</option></select>');
			    } else{
			    	 $('#bateria').html('<select disabled><option>1ºCiclo</option></select>');
			    }
		});
		});
	</script>
</body>
</html>