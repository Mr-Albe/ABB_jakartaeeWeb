<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion Stations</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    
    <style>
        .error { color: red; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 150px; }
    </style>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="${pageContext.request.getContextPath()}/dashboard.jsp ">Accueil</a></li>
                <li><a href="${pageContext.request.getContextPath()}/StationServlet">Stations</a></li>
                <li><a href="${pageContext.request.getContextPath()}/ApprovisionnementServlet">Approvisionnements</a></li>
                <li><a href="${pageContext.request.getContextPath()}/VenteServlet">Ventes</a></li>
                <li><a href="${pageContext.request.getContextPath()}/logout">Déconnexion</a></li>
            </ul>
        </nav>
        <hr>       
    </header>
