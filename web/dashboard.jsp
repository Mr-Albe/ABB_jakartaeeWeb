<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifie si l'utilisateur est connecte
    if (session.getAttribute("username") == null) {
        // Redirige vers la page de connexion
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="/layout/header.jsp" %>

<h3>Bienvenue sur le tableau de bord</h3>
<p>Voici un aperçu des opérations des stations...</p>

<%@ include file="/layout/footer.jsp" %>
