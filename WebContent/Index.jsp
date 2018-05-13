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
<div class="contain">
	<label>FASE:</label>
	<select id="fase">
		<option>--</option>
		<option>INICIAL</option>
		<option>FINAL</option>
	</select>
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
		<td>cell1_1</td>
		<td>cell2_1</td>
		<td>cell3_1</td>
		<td>cell4_1</td>
		</tr>
		</tbody>
	</table>
	<table class="blueTable"id="tabela2" style="display:none;">
		<thead>
		<tr>
		<th style="color:#000;">Cód</th>
		<th style="color:#000;">Atleta</th>
		<th style="color:#000;">País</th>
		<th style="color:#000;">Resultado</th>
		</tr>
		</thead>
		<tbody>
		<tr>
		<td>cell1_1</td>
		<td>cell2_1</td>
		<td>cell3_1</td>
		<td>cell4_1</td>
		</tr>
		</tbody>
	</table>
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
	<div class="aside">
		<form method="post" action="./controlePesquisa">
			<h3 align="center">Quero Pesquisar</h3>
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
						<label>BATERIA:</label>
						<select class="posicao" id="bateria" name="bateria">
							<option>1ºCiclo</option>
						</select>
							<label>FASE:</label>
						<select class="posicao" id="fase" name="fase">
							<option value="INICIAL">INICIAL</option>
							<option value="FINAL">FINAL</option>
						</select>
						<button id="ir" >Ir! </button>
			</form>
	</div>
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
</body>
</html>