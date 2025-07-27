<%@page import="model.VenteModel"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp" %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<div class="content flex-1 overflow-auto">
    <div class="container mx-auto px-4 py-6">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6">
            <h2 class="text-2xl font-bold text-gray-800">Liste des ventes</h2>
            <a href="${pageContext.request.getContextPath()}/vente/ajouter.jsp" 
               class="mt-4 md:mt-0 inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300">
                <i class="fas fa-plus mr-2"></i> Nouvelle vente
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
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Prix unitaire</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Revenue</th>
                            <!--<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>-->
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <%
                            List<VenteModel> listVente = (List<VenteModel>) request.getAttribute("vente");
                            String erreur = (String) request.getAttribute("erreur");

                            if (listVente != null && !listVente.isEmpty()) {
                                for (VenteModel vente : listVente) {
                        %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= vente.getId()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= vente.getStationId()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                      <%= "gazoline".equalsIgnoreCase(vente.getTypeCarburant()) ? "bg-blue-100 text-blue-800" : "bg-gray-100 text-gray-800"%>">
                                    <%= vente.getTypeCarburant()%>
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= vente.getQuantite()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= String.format("%,.2f", vente.getPrixUnitaire())%> HTG</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= vente.getDateVente()%></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= String.format("%,.2f", vente.getRevenu())%> HTG</td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td colspan="8" class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                <%= (erreur != null) ? erreur : "Aucune vente trouvée."%>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="/layout/footer.jsp" %>