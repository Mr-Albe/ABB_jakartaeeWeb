<%
    // Verifie si l'utilisateur est connecte
    if (session.getAttribute("user") == null) {
        // Redirige vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>