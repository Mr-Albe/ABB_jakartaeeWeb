
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layout/header.jsp" %>

<!-- Formulaire d'ajout / modification -->

<%
    String erreur = (String) request.getAttribute("erreur");
    if (erreur != null) {
%>
    <div style="color: red; background-color: #fee; padding: 10px; border: 1px solid red; margin-bottom: 10px;">
        <%= erreur %>
    </div>
<% } %>

<h3>Ajouter une Station</h3>
<form action="<%= request.getContextPath() %>/StationServlet" method="post">
    <input type="hidden" name="action" value="add" />
    <div class="form-group"> 
        <label>Numéro:</label>
        <input type="text" name="numero" value="<%= request.getAttribute("numero") != null ? request.getAttribute("numero") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Rue:</label>
        <input type="text" name="rue" value="<%= request.getAttribute("rue") != null ? request.getAttribute("rue") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Commune:</label>
        <input type="text" name="commune" value="<%= request.getAttribute("commune") != null ? request.getAttribute("commune") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Capacité Gazoline:</label>
        <input type="number" name="capaciteGazoline" min="0" value="<%= request.getAttribute("capaciteGazoline") != null ? request.getAttribute("capaciteGazoline") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Quantité Gazoline Disponible:</label>
        <input type="number" name="quantiteGazoline" min="0" value="<%= request.getAttribute("quantiteGazoline") != null ? request.getAttribute("quantiteGazoline") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Capacité Diesel:</label>
        <input type="number" name="capaciteDiesel" min="0" value="<%= request.getAttribute("capaciteDiesel") != null ? request.getAttribute("capaciteDiesel") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <label>Quantité Diesel Disponible:</label>
        <input type="number" name="quantiteDiesel" min="0" value="<%= request.getAttribute("quantiteDiesel") != null ? request.getAttribute("quantiteDiesel") : ""%>" required />
    </div>
    
    <div class="form-group"> 
        <button type="submit">Enregistrer la station</button>
    </div>
    
</form>

<%@ include file="/layout/footer.jsp" %>