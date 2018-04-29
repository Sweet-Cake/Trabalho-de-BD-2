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
	<button class="btn">Ir!</button>
	<table class="blueTable"id="tabela">
		<thead>
		<tr>
		<th>Código</th>
		<th>Atleta</th>
		<th>País</th>
		<th>Resultado</th>
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
</form>
</div>
</body>
</html>