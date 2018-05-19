<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, dao.*, java.util.*,model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/style.css"/>
<title>Atletismo</title>

<script src="https://code.jquery.com/jquery-1.6.2.js" integrity="sha256-pXKSYZ0U64y9kjvenyjPmUrGarxI98l1t2kyj/M73ck=" crossorigin="anonymous"></script>
	<script text="text/javascript">
			$(document).ready(function(){
				$('#inserir').click(function(){
					
					var Fase = $("#fase option:selected").val();
					var Atleta = $("#atleta option:selected").val();
					var Prova = $("#prova option:selected").text();
					var Bateria = $("#bateria option:selected").val();
					var Desempenho = $("#time").val();
					$.ajax({
						type:'POST',
						data:{fase: Fase,
							atleta: Atleta,
							prova: Prova,
							bateria: Bateria,
							desempenho: Desempenho
						},
						url:'controleAdd',
						success: function(result){
					alert('Fase: '+Prova);
					}
					})
				});
			});
	</script>



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
			<label>FASE:</label>
			<select name="fase" id="fase">
				<option value="1">INICIAL</option>
				<option value="2">FINAL</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label>Prova:</label>
			<select id="prova" >
			<option>--</option></select>
			</select>
			
		</td>
	</tr>
	<tr>
		<td>
			<label>Atleta:</label>
			<select name="atleta" id="atleta">
			<option>--</option></select>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<label>Bateria:</label>
			<select id="bateria">
			<option>--</option></select>
			</select>
		</td>
	</tr>
		<tr>
		<td>
			<label>Desempenho:</label>
			<input type="" id="time" name = "time" style="width:130px;"/>
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn" id="inserir">Inserir</button>
		</td>
	</tr>
</table>
</div>
	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#fase').change(function(){
			var ss=$('#fase option:selected').val();
			$('#atleta').html('<select disabled><option>--</option></select>');
			$('#bateria').html('<select disabled><option>--</option></select>');
			if(ss==1) {
				var cmd = "inicial";
				$.ajax({
					type:'POST',
					data:{cmd: cmd,
					},
					url:'Teste',
					success: function(result){
						$('#prova').html(result);
				}})
		    } else{
		    	var cmd = "final";
				$.ajax({
					type:'POST',
					data:{cmd: cmd,
					},
					url:'Teste',
					success: function(result){
						$('#prova').html(result);
				}})
		    }
		});
		});
	</script>

	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#prova').change(function(){
			var ss=$('#prova option:selected').text();
			if(ss!='Marie') {
					alert('Calie');
			    }
		});
		});
	</script>

	<script src="https://code.jquery.com/jquery-1.10.1.js" integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
		$('#prova').change(function(){
			var ss=$('#prova option:selected').val();
			if(ss==1) {
					$('#bateria').html('<select id="bateria"><option>1ºCiclo</option><option>2ºCiclo</option><option>3ºCiclo</option><option>4ºCiclo</option><option>5ºCiclo</option><option>6ºCiclo</option></select>');
					$('#time').prop('type', 'text');
					document.getElementById("time").value = " ";
			    } else{
			    	if(ss==2){
			    		$('#bateria').html('<select id="bateria"><option>1ºCiclo</option><option>2ºCiclo</option><option>3ºCiclo</option><option>4ºCiclo</option><option>5ºCiclo</option><option>6ºCiclo</option></select>');
			    	 $('#time').prop('type', 'text');
			    	 document.getElementById("time").value = "00:00:00:000";
			    	}else {
			    		$('#bateria').html('<select disabled><option>--</option></select>');
						$('#time').prop('type', 'text');
						document.getElementById("time").value = "--";
			    	}
			    }
			if(ss!=0){
				var ff = $("#fase option:selected").val();
				var prova = $("#prova option:selected").text();
				if (ff==1){
					var cmd = "prova";
					$.ajax({
						type:'POST',
						data:{cmd: cmd,
							prova: prova,
						},
						url:'Teste',
						success: function(result){
							$('#atleta').html(result);
					}})
				}else{
					var cmd = "provaf";
					$.ajax({
						type:'POST',
						data:{cmd: cmd,
							prova: prova,
						},
						url:'Teste',
						success: function(result){
							$('#atleta').html(result);
					}})
				}
				
			}
		});
		});
	</script>
</body>
</html>