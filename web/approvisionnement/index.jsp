<%@page import="model.ApprovisionnementModel"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<div class="content flex-1 overflow-auto">
    <div class="container mx-auto px-4 py-6">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Liste des approvisionnements</h2>
            <a href="${pageContext.request.getContextPath()}/approvisionnement/ajouter.jsp" class="mt-4 md:mt-0 inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300">
                <i class="fas fa-plus mr-2"></i> Nouvelle livraison
            </a>
        </div>

        <div class="bg-white rounded-lg shadow overflow-hidden">

            <div class="table-responsive">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Station</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantité (G)</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fournisseur</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <%           List<ApprovisionnementModel> listApp = (List<ApprovisionnementModel>) request.getAttribute("listApprovisionnement");
                            String erreur = (String) session.getAttribute("erreur");

                            if (listApp != null && !listApp.isEmpty()) {
                                for (ApprovisionnementModel app : listApp) {

                        %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= app.getId()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= app.getNumStation()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <span class="badge badge-gasoline"><%= app.getTypeCarburant()%></span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= app.getQuantite()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= app.getDateLivraison()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= app.getFournisseur()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <a href="ApprovisionnementServlet?action=edit&id=<%= app.getId()%>" class="text-blue-600 hover:text-blue-900 mr-3"><i class="fas fa-edit"></i></a>
                                <a href="ApprovisionnementServlet?action=delete&id=<%= app.getId()%>" class="text-red-600 hover:text-red-900" onclick="return confirm('Supprimer cet approvisionnement ?');"><i class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                        <% }
                        } else {%>
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
            </div>
        </div>
    </div>
</div>

<%@ include file="/layout/footer.jsp" %>
