<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.StationModel" %>
<%@ include file="/layout/header.jsp" %>

<div class="max-w-7xl mx-auto px-4 py-6">

    <!-- Bouton nouvelle station -->
    <div class="mb-6">
        <a href="<%= request.getContextPath()%>/stations/ajouter.jsp"
           class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded shadow">
            + Nouvelle station
        </a>
    </div>

    <!-- Tableau des stations avec % automatique -->
    <h3 class="text-xl font-bold mb-4">Liste des Stations</h3>
    <div class="overflow-x-auto">
        <table class="min-w-full table-auto border border-gray-300">
            <thead class="bg-gray-100">
                <tr>
                    <th class="border px-4 py-2">ID</th>
                    <th class="border px-4 py-2">Adresse</th>
                    <th class="border px-4 py-2">Capacité Gazoline</th>
                    <th class="border px-4 py-2">Quantité Gazoline</th>
                    <th class="border px-4 py-2">% Gazoline</th>
                    <th class="border px-4 py-2">Capacité Diesel</th>
                    <th class="border px-4 py-2">Quantité Diesel</th>
                    <th class="border px-4 py-2">% Diesel</th>
                    <th class="border px-4 py-2">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<StationModel> listStation = (List<StationModel>) request.getAttribute("listStation");
                    String erreur = (String) request.getAttribute("erreur");

                    if (listStation != null && !listStation.isEmpty()) {
                        for (StationModel st : listStation) {
                            double pourcentageGazoline = (st.getCapaciteGazoline() > 0)
                                ? (st.getQuantiteGazoline() * 100.0 / st.getCapaciteGazoline()) : 0;
                            double pourcentageDiesel = (st.getCapaciteDiesel() > 0)
                                ? (st.getQuantiteDiesel() * 100.0 / st.getCapaciteDiesel()) : 0;
                %>
                <tr class="text-center hover:bg-gray-50">
                    <td class="border px-4 py-2"><%= st.getId() %></td>
                    <td class="border px-4 py-2"><%= "#" + st.getNumero() + " " +st.getRue()+ " " + st.getCommune() %></td>
                    <td class="border px-4 py-2"><%= st.getCapaciteGazoline() %></td>
                    <td class="border px-4 py-2"><%= st.getQuantiteGazoline() %></td>
                    <td class="border px-4 py-2 text-green-700 font-semibold">
                        <%= String.format("%.2f", pourcentageGazoline) %> %
                    </td>
                    <td class="border px-4 py-2"><%= st.getCapaciteDiesel() %></td>
                    <td class="border px-4 py-2"><%= st.getQuantiteDiesel() %></td>
                    <td class="border px-4 py-2 text-green-700 font-semibold">
                        <%= String.format("%.2f", pourcentageDiesel) %> %
                    </td>
                    <td class="border px-4 py-2 space-x-2">
                        <a href="StationServlet?action=edit&id=<%= st.getId() %>"
                           class="bg-blue-500 hover:bg-blue-600 text-white px-5 mb-4 py-1 rounded-md text-sm font-medium shadow inline-flex items-center gap-1">
                            Modifier
                        </a>
                        <a href="StationServlet?action=delete&id=<%= st.getId() %>"
                           class="bg-red-500 hover:bg-red-600 text-white px-5 py-1 rounded-md text-sm font-medium shadow"
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
                    <td colspan="9" class="text-center py-4 text-gray-500">
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

<%@ include file="/layout/footer.jsp" %>
