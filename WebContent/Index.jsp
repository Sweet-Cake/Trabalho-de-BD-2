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
	<p class="mund" id ="mund" value="2" style="display:block;"><marquee width="300" scrollamount="300" scrolldelay="300">Mundial:</marquee></p><input class="esq" value="--" type="text/css">
	<p class="even" style="display:block;"><marquee width="300" scrollamount="300" scrolldelay="300">Evento:</marquee></p> <input class="dir" type="text/css"/>
</div>
	<script src="https://code.jquery.com/jquery-1.6.2.js" integrity="sha256-pXKSYZ0U64y9kjvenyjPmUrGarxI98l1t2kyj/M73ck=" crossorigin="anonymous"></script>
	<script text="text/javascript">
	</script>
		
<div class="topo">
<form method="post" action="./controlePesquisa">
	<label>FASE:</label>
	<select name="fase1">
		<option>--</option>
		<option>INICIAL</option>
		<option>FINAL</option>
	</select>
	<label>PROVA:</label>
	<select name ="prova1">
		<option>--</option>
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
			<table id="tabelar" class = "blueTable" border="1px">
		<tr class="corTr">
			<td> Evento</td>
			<td> Mundial</td>
		</tr>
		<tr id="recordes">
			<td id="evento"></td>
			<td id="mundial"></td>
		</tr>
	</table>
		<%
			   List<Desempenho> prova = (List<Desempenho>)request.getAttribute("PROVA"); 
			   	if (prova != null && prova.size() > 0) { 
				%>
					<style>
						p{
							display:none;
						}
					</style>
	<table class="blueTable"id="tabela">
		<thead>
		<tr>
		<th style="color:#000;">C�digo</th>
		<th style="color:#000;">Atleta</th>
		<th style="color:#000;">Pa�s</th>
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
	</table><% 
				}else{
					%> 
					<p align="center" style="margin-left:10%;background-color:red;">Esse Evento ainda n�o Aconteceu!</p>
				<%}%>
		<% 
				List<Desempenho> d = (List<Desempenho>)request.getAttribute("DESEMPENHO"); 
			   	if (d != null && d.size() > 0) { 
				%>
				<table class="blueTable"id="tabela3">
					<style>
						#tabela,#tabela2,p{
							display:none;
						}
					</style>
					<thead>
					<tr>
					<th style="color:#000;">Code</th>
					<th style="color:#000;">Atleta</th>
					<th style="color:#000;">Pa�s</th>
					<th style="color:#000;">Resultado</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<%
					int a = 1;
					for (Desempenho des : d) {  %>
					<td id="<%=des.getCodAtl() %>"><%=a %></td>
					<td id="<%=des.getCodAtl() %>"><%= des.getNome()%></td>
					<td id="<%=des.getCodAtl() %>"><%=des.getPais() %></td>
					<td id="<%=des.getCodAtl() %>"><%=des.getResultado()%></td>
					</tr>
					<%a++; } %>
					</tbody>
				</table>
				<%
				}else{
					%>
					<p align="center" style="margin-left:10%;background-color:red;">Esse Evento ainda n�o Aconteceu!</p>
				<%}%>
</div>
<div class="aside">
			<h3 align="center">Quero Pesquisar</h3>
			<table id="shame">
			<tr>
			<td>
				<label>PROVA:</label>
						<select class="posicao" id="prova" name="prova">
							<option>--</option>
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
							<option>--</option>
							<option>1�Ciclo</option>
							<option>2�Ciclo</option>
							<option>3�Ciclo</option>
							<option>4�Ciclo</option>
							<option>5�Ciclo</option>
							<option>6�Ciclo</option>
						</select>
				</td>
				</tr>
				<tr>
				<td>
					<label>FASE:</label>
						<select class="posicao" id="fase" name="fase">
							<option>--</option>
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
		$('#prova').change(function(){
			var Prova = $("#prova option:selected").text();
			var cmd = "recorde";
			$.ajax({
				type:'POST',
				data:{prova: Prova,
					cmd: cmd
				},
				url:'Teste',
				success: function(result){
			alert('Fase: '+Prova);
			$("#evento").text(result);
			$("#1").text('saa');
			}
			})
		});
		});
	</script>
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
					$('#bateria').html('<select id="bateria"><option>1�Ciclo</option><option>2�Ciclo</option><option>3�Ciclo</option><option>4�Ciclo</option><option>5�Ciclo</option><option>6�Ciclo</option></select>');
			    } else{
			    	 $('#bateria').html('<select disabled><option>1�Ciclo</option></select>');
			    }
		});
		});
	</script>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#ir').click(function(){
		});
		});
	</script>
		<%session.setAttribute("DESEMPENHO", null);
		  session.setAttribute("PROVA", null);
		%>
</body>
</html>