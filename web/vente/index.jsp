<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Ventes</title>
</head>
<body>
    <h1>Liste des Ventes</h1>
    <c:if test="${not empty erreur}">
        <p style="color:red">${erreur}</p>
    </c:if>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Station</th>
            <th>Type</th>
            <th>Quantité</th>
            <th>Prix</th>
            <th>Date</th>
        </tr>
        <c:forEach items="${vente}" var="v">
            <tr>
                <td>${v.id}</td>
                <td>${v.stationId}</td>
                <td>${v.typeCarburant}</td>
                <td>${v.quantite}</td>
                <td>${v.prixUnitaire}</td>
                <td>${v.dateVente}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>