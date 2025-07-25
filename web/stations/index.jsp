<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.StationModel" %>
<%@ include file="/layout/header.jsp" %>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">

    <!-- Bouton nouvelle station -->
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-2xl font-bold text-gray-800">Gestion des Stations</h1>
        <a href="<%= request.getContextPath()%>/stations/ajouter.jsp"
           class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg shadow-md transition duration-200 ease-in-out transform hover:-translate-y-1">
            + Nouvelle station
        </a>
    </div>

    <!-- Tableau des stations avec % automatique -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <div class="p-4 border-b border-gray-200">
            <h3 class="text-lg font-semibold text-gray-700">Liste des Stations</h3>
        </div>
        
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Adresse</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Capacité Gazoline</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantité Gazoline</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">% Gazoline</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Capacité Diesel</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantité Diesel</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">% Diesel</th>
                        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <%
                        List<StationModel> listStation = (List<StationModel>) request.getAttribute("listStation");
                        String erreur = (String) request.getAttribute("erreur");

                        if (listStation != null && !listStation.isEmpty()) {
                            for (StationModel st : listStation) {
                                double pourcentageGazoline = (st.getCapaciteGazoline() > 0)
                                    ? (st.getQuantiteGazoline() * 100.0 / st.getCapaciteGazoline()) : 0;
                                double pourcentageDiesel = (st.getCapaciteDiesel() > 0)
                                    ? (st.getQuantiteDiesel() * 100.0 / st.getCapaciteDiesel()) : 0;
                                
                                // Déterminer la couleur en fonction du pourcentage
                                String gazolineColor = pourcentageGazoline < 20 ? "text-red-600" : "text-green-600";
                                String dieselColor = pourcentageDiesel < 20 ? "text-red-600" : "text-green-600";
                    %>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= st.getId() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= "#" + st.getNumero() + ", " +st.getRue()+ ", " + st.getCommune() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= st.getCapaciteGazoline() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= st.getQuantiteGazoline() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold <%= gazolineColor %>">
                            <%= String.format("%.2f", pourcentageGazoline) %> %
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= st.getCapaciteDiesel() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= st.getQuantiteDiesel() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold <%= dieselColor %>">
                            <%= String.format("%.2f", pourcentageDiesel) %> %
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-2">
                            <a href="StationServlet?action=edit&id=<%= st.getId() %>"
                               class="text-blue-600 hover:text-blue-900 bg-blue-50 hover:bg-blue-100 px-3 py-1 rounded-md text-sm font-medium transition duration-200">
                                Modifier
                            </a>
                            <a href="StationServlet?action=delete&id=<%= st.getId() %>"
                               class="text-red-600 hover:text-red-900 bg-red-50 hover:bg-red-100 px-3 py-1 rounded-md text-sm font-medium transition duration-200"
                               onclick="return confirm('Supprimer cette station ?');">
                                Supprimer
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" class="px-6 py-4 text-center text-sm text-gray-500 italic">
                            <%= (erreur != null) ? erreur : "Aucune station trouvée." %>
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

<%@ include file="/layout/footer.jsp" %>