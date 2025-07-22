<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.StationModel" %>
<%@ include file="/layout/header.jsp" %>
<%
    StationModel station = (StationModel) request.getAttribute("station");
    if (station == null) {
        station = new StationModel();
    }
    
    String error = (String) request.getAttribute("error");
    boolean isEdit = station != null;
   
%>
    <h2>Modifier une station</h2>
    
    <% if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/StationServlet">
        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "" %>">
        
        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= station.getId()%>">
        <% } %>
        
        <div class="form-group">
            <label for="numero">Numéro:</label>
            <input type="text" id="numero" name="numero" 
                   value="<%= isEdit ? station.getNumero() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="rue">Rue:</label>
            <input type="text" id="rue" name="rue" 
                   value="<%= isEdit ? station.getRue() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="commune">Commune:</label>
            <input type="text" id="commune" name="commune" 
                   value="<%= isEdit ? station.getCommune() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="capaciteGazoline">Capacité Gazoline:</label>
            <input type="number" id="capaciteGazoline" name="capaciteGazoline" min="1"
                   value="<%= isEdit ? station.getCapaciteGazoline() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="quantiteGazoline">Quantité Gazoline:</label>
            <input type="number" id="quantiteGazoline" name="quantiteGazoline" min="0"
                   value="<%= isEdit ? station.getQuantiteGazoline() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="capaciteDiesel">Capacité Diesel:</label>
            <input type="number" id="capaciteDiesel" name="capaciteDiesel" min="1"
                   value="<%= isEdit ? station.getCapaciteDiesel() : "" %>" required>
        </div>
        
        <div class="form-group">
            <label for="quantiteDiesel">Quantité Diesel:</label>
            <input type="number" id="quantiteDiesel" name="quantiteDiesel" min="0"
                   value="<%= isEdit ? station.getQuantiteDiesel() : "" %>" required>
        </div>
        
        <div class="form-group">
            <button type="submit">Enregistrer</button>
            <a href="StationServlet">Annuler</a>
        </div>
    </form>

    <%-- Validation côté client --%>
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const capGaz = parseInt(document.getElementById('capaciteGazoline').value);
            const qteGaz = parseInt(document.getElementById('quantiteGazoline').value);
            const capDie = parseInt(document.getElementById('capaciteDiesel').value);
            const qteDie = parseInt(document.getElementById('quantiteDiesel').value);
            
            if (qteGaz > capGaz) {
                alert('La quantité Gazoline ne peut pas dépasser la capacité');
                e.preventDefault();
                return false;
            }
            
            if (qteDie > capDie) {
                alert('La quantité Diesel ne peut pas dépasser la capacité');
                e.preventDefault();
                return false;
            }
            
            return true;
        });
    </script>

<%@ include file="/layout/footer.jsp" %>