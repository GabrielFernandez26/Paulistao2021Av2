<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel='stylesheet' href='css/style.css'/>
<title>Classificacao</title>
</head>
<body>
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

	<div class="classificacao">
		<img alt="Logo" src="./assets/logo.png">
		<form action="classificacao" method="get">
			
		</form>
		<div>
			<table align="center">
				<tr>
					<th class='Resultado'>Time</th>
					<th class='Resultado'>Jogos</th>
					<th class='Resultado'>Vitorias</th>
					<th class='Reultado'>Empates</th>
					<th class='Resultado'>Derrotas</th>
					<th class='Resultado'>Gols Marcados</th>
					<th class='Resultado'>Gols Sofridos</th>
					<th class='Resultado'>Saldo de Gols</th>
					<th class='Resultado'>Pontos</th>
				</tr>
				<c:forEach items="${resultados}" var="r">
					<tr>
						<td align="center"><c:out value="${r.getTime()}"></c:out></td>
						<td align="center"><c:out value="${r.getPartidas()}"></c:out></td>
						<td align="center"><c:out value="${r.getVitorias()}"></c:out></td>
						<td align="center"><c:out value="${r.getEmpates()}"></c:out></td>
						<td align="center"><c:out value="${r.getDerrotas()}"></c:out></td>
						<td align="center"><c:out value="${r.getGolsMarcados()}"></c:out></td>
						<td align="center"><c:out value="${r.getGolsSofridos()}"></c:out></td>
						<td align="center"><c:out value="${r.getSaldoGols()}"></c:out></td>
						<td align="center"><c:out value="${r.getPontos()}"></c:out></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<form action="classificacaoGrupo" method="post">
			<input type="submit" id=grupos name=grupos
				value="Classificacao por Grupo">
		</form>
		<div>
			<h4>Grupo A</h4>
			<table align="center">
				<tr>
					<th class='Resultado'>Time</th>
					<th class='Resultado'>Jogos</th>
					<th class='Resultado'>Vitorias</th>
					<th class='Reultado'>Empates</th>
					<th class='Resultado'>Derrotas</th>
					<th class='Resultado'>Gols Marcados</th>
					<th class='Resultado'>Gols Sofridos</th>
					<th class='Resultado'>Saldo de Gols</th>
					<th class='Resultado'>Pontos</th>
				</tr>
				<c:forEach items="${resultadoGrupoA}" var="resA">
					<tr>
						<td align="center"><c:out value="${resA.getTime()}"></c:out></td>
						<td align="center"><c:out value="${resA.getPartidas()}"></c:out></td>
						<td align="center"><c:out value="${resA.getVitorias()}"></c:out></td>
						<td align="center"><c:out value="${resA.getEmpates()}"></c:out></td>
						<td align="center"><c:out value="${resA.getDerrotas()}"></c:out></td>
						<td align="center"><c:out value="${resA.getGolsMarcados()}"></c:out></td>
						<td align="center"><c:out value="${resA.getGolsSofridos()}"></c:out></td>
						<td align="center"><c:out value="${resA.getSaldoGols()}"></c:out></td>
						<td align="center"><c:out value="${resA.getPontos()}"></c:out></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<h4>Grupo B</h4>
			<table align="center">
				<tr>
					<th class='Resultado'>Time</th>
					<th class='Resultado'>Jogos</th>
					<th class='Resultado'>Vitorias</th>
					<th class='Reultado'>Empates</th>
					<th class='Resultado'>Derrotas</th>
					<th class='Resultado'>Gols Marcados</th>
					<th class='Resultado'>Gols Sofridos</th>
					<th class='Resultado'>Saldo de Gols</th>
					<th class='Resultado'>Pontos</th>
				</tr>
				<c:forEach items="${resultadoGrupoB}" var="resB">
					<tr>
						<td align="center"><c:out value="${resB.getTime()}"></c:out></td>
						<td align="center"><c:out value="${resB.getPartidas()}"></c:out></td>
						<td align="center"><c:out value="${resB.getVitorias()}"></c:out></td>
						<td align="center"><c:out value="${resB.getEmpates()}"></c:out></td>
						<td align="center"><c:out value="${resB.getDerrotas()}"></c:out></td>
						<td align="center"><c:out value="${resB.getGolsMarcados()}"></c:out></td>
						<td align="center"><c:out value="${resB.getGolsSofridos()}"></c:out></td>
						<td align="center"><c:out value="${resB.getSaldoGols()}"></c:out></td>
						<td align="center"><c:out value="${resB.getPontos()}"></c:out></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<h4>Grupo C</h4>
			<table align="center">
				<tr>
					<th class='Resultado'>Time</th>
					<th class='Resultado'>Jogos</th>
					<th class='Resultado'>Vitorias</th>
					<th class='Reultado'>Empates</th>
					<th class='Resultado'>Derrotas</th>
					<th class='Resultado'>Gols Marcados</th>
					<th class='Resultado'>Gols Sofridos</th>
					<th class='Resultado'>Saldo de Gols</th>
					<th class='Resultado'>Pontos</th>
				</tr>
				<c:forEach items="${resultadoGrupoC}" var="resC">
					<tr>
						<td align="center"><c:out value="${resC.getTime()}"></c:out></td>
						<td align="center"><c:out value="${resC.getPartidas()}"></c:out></td>
						<td align="center"><c:out value="${resC.getVitorias()}"></c:out></td>
						<td align="center"><c:out value="${resC.getEmpates()}"></c:out></td>
						<td align="center"><c:out value="${resC.getDerrotas()}"></c:out></td>
						<td align="center"><c:out value="${resC.getGolsMarcados()}"></c:out></td>
						<td align="center"><c:out value="${resC.getGolsSofridos()}"></c:out></td>
						<td align="center"><c:out value="${resC.getSaldoGols()}"></c:out></td>
						<td align="center"><c:out value="${resC.getPontos()}"></c:out></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div>
			<h4>Grupo D</h4>
			<table align="center">
				<tr>
					<th class='Resultado'>Time</th>
					<th class='Resultado'>Jogos</th>
					<th class='Resultado'>Vitorias</th>
					<th class='Reultado'>Empates</th>
					<th class='Resultado'>Derrotas</th>
					<th class='Resultado'>Gols Marcados</th>
					<th class='Resultado'>Gols Sofridos</th>
					<th class='Resultado'>Saldo de Gols</th>
					<th class='Resultado'>Pontos</th>
				</tr>
				<c:forEach items="${resultadoGrupoD}" var="resD">
					<tr>
						<td align="center"><c:out value="${resD.getTime()}"></c:out></td>
						<td align="center"><c:out value="${resD.getPartidas()}"></c:out></td>
						<td align="center"><c:out value="${resD.getVitorias()}"></c:out></td>
						<td align="center"><c:out value="${resD.getEmpates()}"></c:out></td>
						<td align="center"><c:out value="${resD.getDerrotas()}"></c:out></td>
						<td align="center"><c:out value="${resD.getGolsMarcados()}"></c:out></td>
						<td align="center"><c:out value="${resD.getGolsSofridos()}"></c:out></td>
						<td align="center"><c:out value="${resD.getSaldoGols()}"></c:out></td>
						<td align="center"><c:out value="${resD.getPontos()}"></c:out></td>
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