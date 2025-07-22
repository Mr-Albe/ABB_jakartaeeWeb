<%@page import="model.ApprovisionnementModel"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layout/header.jsp" %>

<h3>Liste des approvisionnements</h3>
<a href="<%= request.getContextPath() %>/approvisionnement/enregistrement.jsp">+ Nouvelle livraison</a><br><br>

<table border="1" cellpadding="8">
    <thead>
        <tr>
            <th>ID</th>
            <th>ID Station</th>
            <th>Type</th>
            <th>Quantité</th>
            <th>Date</th>
            <th>Fournisseur</th>
            <th>Action</th>

        </tr>
    </thead>
    <tbody>
       <% 
        List<ApprovisionnementModel> listApp = (List<ApprovisionnementModel>) request.getAttribute("listApprovisionnement");
        String erreur = (String)request.getAttribute("erreur");
        
        if(listApp != null && !listApp.isEmpty()){
            for(ApprovisionnementModel app: listApp){
           
       %>
       <tr>
            <td><%= app.getId()%></td>
            <td><%= app.getStationId() %></td>
            <td><%= app.getTypeCarburant() %></td>
            <td><%= app.getQuantite() %></td>
            <td><%= app.getDateLivraison() %> </td>
            <td><%= app.getFournisseur()%> </td>
            <td>
                <a href="ApprovisionnementServlet?action=edit&id=<%= app.getId()%>">Modifier</a> |
                <a href="ApprovisionnementServlet?action=delete&id=<%= app.getId()%>">Supprimer</a>  
                <!--onclick="return confirm('Supprimer cette station ?');-->
            </td>
        </tr>
        <% }
        } else { %>
        
        <tr>
            <td colspan="9" style="text-align: center;">
                <%= (erreur != null) ? erreur : "Aucune station trouvée."%>
            </td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

<%@ include file="/layout/footer.jsp" %>
