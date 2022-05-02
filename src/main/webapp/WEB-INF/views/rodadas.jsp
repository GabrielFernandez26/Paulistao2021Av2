<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel='stylesheet' href='css/style.css'/>
<title>Rodada</title>
</head>
<body>
	<div class="header">
		<ul>
			<li><a href="index" class="link-grupos">Grupos</a></li>
			<li><a href="jogos" class="link-jogos">Jogos</a></li>
			<li><a href="rodadas" class="link-rodadas">Rodadas</a></li>
			<li><a href="classificacao" class="link-classificacao">Classificacao</a></li>
			<li><a href="quartas" class="link-quartas">Quartas de Finais</a></li>
		</ul>
	</div>
	<br>
	<br>
	<div class="jogos">
		<img alt="Logo" src="./assets/logo.png">
		<form action="rodadas" method="POST">
			<input type="date" name="data"> <input type="submit" id="listar_rodada" name="listar_rodada"
				value="Mostrar rodada">
		</form>
		<table class="center">
			<tr>
				<th class='Jogo'>Time A</th>
				<th class='Jogo'>Time B</th>
				<th class='Jogo'>Gols (Time A)</th>
				<th class='Jogo'>Gols(Time B)</th>
				<th class='Jogo'>Data da Rodada</th>
			</tr>
			<c:forEach items="${jogos}" var="j">
				<tr>
					<td align="center"><c:out value="${j.getTimeA()}"></c:out></td>
					<td align="center"><c:out value="${j.getTimeB()}"></c:out></td>
					<td align="center"><c:out value="${j.getGolsTimeA()}"></c:out></td>
					<td align="center"><c:out value="${j.getGolsTimeB()}"></c:out></td>
					<td align="center"><c:out value="${j.getData()}"></c:out></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div align="center">
		<c:if test="${not empty saida}">
			<h4>
				<c:out value="${saida}"></c:out>
			</h4>
		</c:if>
		<br />
		<div align="center">
			<c:if test="${not empty erro}">
				<h4>
					<c:out value="${erro}"></c:out>
				</h4>
			</c:if>
		</div>
	</div>

</body>
</html>