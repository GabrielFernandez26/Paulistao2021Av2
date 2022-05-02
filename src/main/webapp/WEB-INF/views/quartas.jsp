<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel='stylesheet' href='css/style.css'/>
<title>Quartas de Finais</title>
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
	<div align="center">
		<c:if test="${not empty erro}">
			<h4>
				<c:out value="${erro}"></c:out>
			</h4>
		</c:if>
	</div>
	
	<div class="quartas-de-finais">
		<img alt="Logo" src="./assets/logo.png">
		<form action="quartas" method="POST">
			<input type="submit" name="listar_quartas" id="listar_quartas"
			value="Listar Quartas">
		</form>
		<div>
			<table align="center">
				<tr>
					<th class='Quartas'>Time A</th>
					<th class='Quartas'>Time B</th>
				</tr>
				<c:forEach items="${jogos}" var="j">
					<tr>
						<td align="center"><c:out value="${j.getTimeA()}"></c:out></td>
						<td align="center"><c:out value="${j.getTimeB()}"></c:out></td>
						
					</tr>
				</c:forEach>
			</table>
		</div>
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