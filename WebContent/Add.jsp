<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<title>Atletismo</title>
</head>
<body>
<div class="head">
	<img class="esquerda"src="img/at.png"/>
	<img class="direita" src="img/at.png"/>
	<h1 align="center">Adicionando o desempenho destes.</h1>
</div>
<div class="contain">
<table>
	<tr>
		<td>
			<label>Atleta:</label>
			<select id="atleta">
				<option>--</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label>Modalidade:</label>
			<select id="modalidade" >
				<option>Corrida</option>
				<option>Salto</option>
			</select>
		</td>
	</tr>
		<tr>
		<td>
			<label>Bateria:</label>
			<select id="bateria">
				<option>1ºSalto</option>
				<option>2ºSalto</option>
				<option>3ºSalto</option>
				<option>4ºSalto</option>
				<option>5ºSalto</option>
				<option>6ºSalto</option>
			</select>
		</td>
	</tr>
		<tr>
		<td>
			<label>Desempenho:</label>
			<input type="text/css"/>
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn">Inserir</button>
		</td>
	</tr>
</table>
</div>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#modalidade').change(function(){
			var ss=$("#modalidade option:selected").val();
			if(ss=="Salto") {
					$('#bateria').html('<select id="bateria"><option>1ºSalto</option><option>2ºSalto</option><option>3ºSalto</option><option>4ºSalto</option><option>5ºSalto</option><option>6ºSalto</option></select>');
			    } else {
			    	 $('#bateria').html('<select disabled></select>');
			    }
		});
		});
	</script>
</body>
</html>