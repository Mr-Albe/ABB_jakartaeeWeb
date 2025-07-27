<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.StationModel" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%    List<StationModel> listStation = (List<StationModel>) session.getAttribute("listStation");

    String erreur = (String) session.getAttribute("erreur");
    int stationCount = listStation != null ? listStation.size() : 0;

    // Calcul des moyennes
    double moyGazoline = 0;
    double moyDiesel = 0;
    if (listStation != null && !listStation.isEmpty()) {
        double totalGazoline = 0;
        double totalDiesel = 0;
        for (StationModel st : listStation) {
            if (st.getCapaciteGazoline() > 0) {
                totalGazoline += (st.getQuantiteGazoline() * 100.0 / st.getCapaciteGazoline());
            }
            if (st.getCapaciteDiesel() > 0) {
                totalDiesel += (st.getQuantiteDiesel() * 100.0 / st.getCapaciteDiesel());
            }
        }
        moyGazoline = totalGazoline / listStation.size();
        moyDiesel = totalDiesel / listStation.size();
    }
%>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Header with title and add button -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
            <h1 class="text-2xl font-bold text-gray-800">Gestion des Stations</h1>
            <p class="text-gray-600 mt-1">Liste complète des stations de carburant</p>
        </div>
        <a href="<%= request.getContextPath()%>/stations/ajouter.jsp"
           class="flex items-center bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg shadow-md transition duration-200 ease-in-out transform hover:-translate-y-1">
            <i class="fas fa-plus mr-2"></i>
            Nouvelle station
        </a>
    </div>

    <%
        if (erreur != null && !erreur.isEmpty()) {
    %>
    <div class="error-message bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-md shadow-sm">
        <div class="flex items-center">
            <div class="flex-shrink-0">
                <i class="fas fa-exclamation-circle text-red-500 text-xl"></i>
            </div>
            <div class="ml-3">
                <p class="text-sm font-medium text-red-800"><%= erreur%></p>
            </div>
        </div>
    </div>
    <%
            session.removeAttribute("erreur");
        }
    %>

    <%
        String success = (String) session.getAttribute("success");
        if (success != null && !success.isEmpty()) {
    %>
    <div class="bg-green-50 border-l-4 border-green-500 p-4 mb-6 rounded-md shadow-sm">
        <div class="flex items-center">
            <div class="flex-shrink-0">
                <i class="fas fa-check-circle text-green-500 text-xl"></i>
            </div>
            <div class="ml-3">
                <p class="text-sm font-medium text-green-800"><%= success%></p>
            </div>
        </div>
    </div>
    <%
            session.removeAttribute("success");
        }
    %>

    <!-- Stats cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-white p-6 rounded-lg shadow-sm border-l-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-500">Stations totales</p>
                    <p class="text-2xl font-semibold text-gray-800"><%= stationCount%></p>
                </div>
                <div class="p-3 rounded-full bg-blue-100 text-blue-600">
                    <i class="fas fa-gas-pump text-xl"></i>
                </div>
            </div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-sm border-l-4 border-green-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-500">Moyenne Gazoline</p>
                    <p class="text-2xl font-semibold text-gray-800"><%= String.format("%.1f", moyGazoline)%>%</p>
                </div>
                <div class="p-3 rounded-full bg-green-100 text-green-600">
                    <i class="fas fa-oil-can text-xl"></i>
                </div>
            </div>
        </div>
        <div class="bg-white p-6 rounded-lg shadow-sm border-l-4 border-yellow-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm font-medium text-gray-500">Moyenne Diesel</p>
                    <p class="text-2xl font-semibold text-gray-800"><%= String.format("%.1f", moyDiesel)%>%</p>
                </div>
                <div class="p-3 rounded-full bg-yellow-100 text-yellow-600">
                    <i class="fas fa-truck text-xl"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Station list -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <div class="p-4 border-b border-gray-200 flex justify-between items-center">
            <h3 class="text-lg font-semibold text-gray-700">Liste des Stations</h3>
            <div class="text-sm text-gray-500">
                <span class="bold" id="station-count"><%= stationCount%></span> stations trouvées
            </div>
        </div>

        <% if (listStation == null || listStation.isEmpty()) {%>
        <!-- Empty state -->
        <div class="text-center bg-white p-12">
            <i class="fas fa-gas-pump text-4xl text-gray-400 mb-4"></i>
            <h3 class="text-lg font-medium text-gray-900 mb-1">Aucune station trouvée</h3>
            <p class="text-gray-500 mb-6"><%= erreur != null ? erreur : "Il n'y a actuellement aucune station enregistrée dans le système."%></p>
            <a href="<%= request.getContextPath()%>/stations/ajouter.jsp"
               class="inline-flex items-center bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-6 rounded-lg shadow-md transition duration-200 ease-in-out">
                <i class="fas fa-plus mr-2"></i>
                Ajouter une station
            </a>
        </div>
        <% } else { %>
        <!-- Desktop table view -->
        <div class="hidden lg:block">
            <div class="overflow-y-auto responsive-table max-h-[50vh]">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Adresse</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gazoline(Gl)</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Diesel(Gl)</th>
                            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200" id="station-table-body">
                        <% for (StationModel st : listStation) {
                                double pourcentageGazoline = (st.getCapaciteGazoline() > 0)
                                        ? (st.getQuantiteGazoline() * 100.0 / st.getCapaciteGazoline()) : 0;
                                double pourcentageDiesel = (st.getCapaciteDiesel() > 0)
                                        ? (st.getQuantiteDiesel() * 100.0 / st.getCapaciteDiesel()) : 0;

                                String gazolineColor = pourcentageGazoline < 20 ? "text-red-600" : "text-green-600";
                                String dieselColor = pourcentageDiesel < 20 ? "text-red-600" : "text-green-600";
                                String gazolineBarColor = pourcentageGazoline < 20 ? "bg-red-500" : "bg-green-500";
                                String dieselBarColor = pourcentageDiesel < 20 ? "bg-red-500" : "bg-green-500";
                        %>
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= st.getId()%></td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900 font-medium">
                                    <%= "#" + st.getNumero() + ", " + st.getRue() + ", " + st.getCommune()%>
                                </div>

                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center gap-4">
                                    <div class="w-24">
                                        <div class="text-sm text-gray-500 mb-1">
                                            <%= st.getQuantiteGazoline()%>/<%= st.getCapaciteGazoline()%> Gl
                                        </div>
                                        <div class="progress-bar">
                                            <div class="progress-fill <%= gazolineBarColor%>" 
                                                 style="width: <%= pourcentageGazoline%>%"></div>
                                        </div>
                                    </div>
                                    <span class="text-sm font-semibold <%= gazolineColor%>">
                                        <%= String.format("%.1f", pourcentageGazoline)%>%
                                    </span>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center gap-4">
                                    <div class="w-24">
                                        <div class="text-sm text-gray-500 mb-1">
                                            <%= st.getQuantiteDiesel()%>/<%= st.getCapaciteDiesel()%> Gl
                                        </div>
                                        <div class="progress-bar">
                                            <div class="progress-fill <%= dieselBarColor%>" 
                                                 style="width: <%= pourcentageDiesel%>%"></div>
                                        </div>
                                    </div>
                                    <span class="text-sm font-semibold <%= dieselColor%>">
                                        <%= String.format("%.1f", pourcentageDiesel)%>%
                                    </span>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-2">
                                <a href="${pageContext.request.contextPath}/StationServlet?action=edit&id=<%= st.getId()%>"
                                   class="text-blue-600 hover:text-blue-900 bg-blue-50 hover:bg-blue-100 px-3 py-1 rounded-md text-sm font-medium transition duration-200">
                                    Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/StationServlet?action=delete&id=<%= st.getId()%>"
                                   class="text-red-600 hover:text-red-900 bg-red-50 hover:bg-red-100 px-3 py-1 rounded-md text-sm font-medium transition duration-200"
                                   onclick="return confirm('Supprimer cette station ?');">
                                    Supprimer
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Mobile card view -->
        <div class="lg:hidden">
            <div class="grid grid-cols-1 gap-4 p-4">
                <% for (StationModel st : listStation) {
                        double pourcentageGazoline = (st.getCapaciteGazoline() > 0)
                                ? (st.getQuantiteGazoline() * 100.0 / st.getCapaciteGazoline()) : 0;
                        double pourcentageDiesel = (st.getCapaciteDiesel() > 0)
                                ? (st.getQuantiteDiesel() * 100.0 / st.getCapaciteDiesel()) : 0;

                        String gazolineColor = pourcentageGazoline < 20 ? "text-red-600" : "text-green-600";
                        String dieselColor = pourcentageDiesel < 20 ? "text-red-600" : "text-green-600";
                        String gazolineBarColor = pourcentageGazoline < 20 ? "bg-red-500" : "bg-green-500";
                        String dieselBarColor = pourcentageDiesel < 20 ? "bg-red-500" : "bg-green-500";
                %>
                <div class="station-card bg-white p-4 rounded-lg shadow-sm border border-gray-100">
                    <div class="flex justify-between items-start mb-2">
                        <div>
                            <h4 class="font-semibold text-gray-900"><%= st.getId()%></h4>
                            <p class="text-sm text-gray-700">
                                <%= "#" + st.getNumero() + ", " + st.getRue() + ", " + st.getCommune()%>
                            </p>

                        </div>
                        <div class="flex space-x-2">
                            <a href="StationServlet?action=edit&id=<%= st.getId()%>"
                               class="text-blue-600 p-1 rounded-full hover:bg-blue-50">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="StationServlet?action=delete&id=<%= st.getId()%>"
                               class="text-red-600 p-1 rounded-full hover:bg-red-50"
                               onclick="return confirm('Supprimer cette station ?');">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="mb-3">
                            <div class="flex justify-between text-sm mb-1">
                                <span class="font-medium">Gazoline</span>
                                <span class="font-semibold <%= gazolineColor%>">
                                    <%= st.getQuantiteGazoline()%>/<%= st.getCapaciteGazoline()%> L (<%= String.format("%.1f", pourcentageGazoline)%>%)
                                </span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill <%= gazolineBarColor%>" style="width: <%= pourcentageGazoline%>%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-sm mb-1">
                                <span class="font-medium">Diesel</span>
                                <span class="font-semibold <%= dieselColor%>">
                                    <%= st.getQuantiteDiesel()%>/<%= st.getCapaciteDiesel()%> L (<%= String.format("%.1f", pourcentageDiesel)%>%)
                                </span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill <%= dieselBarColor%>" style="width: <%= pourcentageDiesel%>%"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <% }%>
    </div>
</div>

<%@ include file="/layout/footer.jsp" %>