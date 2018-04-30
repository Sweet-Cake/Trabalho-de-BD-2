<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/estilo.css"/>
<title>Atletismo</title>
</head>
<body>
<div class="head">
	<img class="esquerda"src="img/at.png"/>
	<img class="direita" src="img/at.png"/>
	<p class="mund"><marquee width="300" scrollamount="300" scrolldelay="300">Mundial:</marquee></p><input class="esq" type="text/css">
	<p class="even"><marquee width="300" scrollamount="300" scrolldelay="300">Evento:</marquee></p> <input class="dir" type="text/css"/>
</div>
<div class="contain">
<form>
	<label>FASE:</label>
	<select id="fase">
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
	<div class="aside">
	<fieldset>
		<legend>Quero Pesquisar:</legend>
		<label>PROVA:</label>
		<select class="posicao">
			<option>//</option>
		</select>
		<label>BATERIA:</label>
		<select class="posicao">
			<option>//</option>
		</select>
			<label>FASE:</label>
		<select class="posicao">
			<option>//</option>
		</select>
		<button>Ir!</button>
	</fieldset>
	</div>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#fase').change(function(){
			var val=$('#fase option:selected').val();
			if (val=="INICIAL"){
				$("#tabela2").css("display","none");
				$("#tabela").css("display","table");
			}else{
				$("#tabela").css("display","none");
				$("#tabela2").css("display","table");
			}
		});
	});
	</script>
	
</form>
</div>
</body>
</html>