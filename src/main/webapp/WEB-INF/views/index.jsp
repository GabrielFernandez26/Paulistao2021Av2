<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" />
<link rel='stylesheet' href='css/style.css' />
<title>Paulistao 2021</title>
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

	<div class="grupos">
		<img alt="Logo" src="./assets/logo.png">
		<form action="grupos" method="post">
			<input type="submit" id="gerar_grupo" name="gerar_grupo"
				value="Gerar Grupos">
		</form>

		<div>

			<table>
				<c:forEach items="${grupos}" var="g">
					<h4>
						<c:out value="${g.getNome()}">
						</c:out>
					</h4>
					<table align="center">
						<tr>
							<th class='Grupo'>Nome</th>
							<th class='Grupo'>Estadio</th>
							<th class='Grupo'>Cidade</th>
						</tr>
						<c:forEach items="${g.getTimes()}" var="t">
							<tr>
								<td align="center"><c:out value="${t.getNome()}"></c:out></td>
								<td align="center"><c:out value="${t.getEstadio()}"></c:out></td>
								<td align="center"><c:out value="${t.getCidade()}"></c:out></td>

							</tr>
						</c:forEach>
					</table>
				</c:forEach>

			</table>
		</div>
		<div align="center">
			<c:if test="${not empty saida}">
				<h4>
					<c:out value="${saida}"></c:out>
				</h4>
			</c:if>
		</div>
	</div>
</body>
</html>
