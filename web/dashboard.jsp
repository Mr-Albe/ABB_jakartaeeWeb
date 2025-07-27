<%@page import="model.VenteModel"%>
<%@page import="model.ApprovisionnementModel"%>
<%@page import="java.util.List"%>
<%@page import="model.StationModel"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="/layout/isConnect.jsp"  %>
<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%    List<StationModel> listStation = (List<StationModel>) session.getAttribute("listeStation");
    List<ApprovisionnementModel> listeAppro = (List<ApprovisionnementModel>) session.getAttribute("listeAppro");
    List<VenteModel> listeVente = (List<VenteModel>) session.getAttribute("listeVente");
    Double totalRevenu = (Double) session.getAttribute("totalRevenu");

    String erreur = (String) session.getAttribute("erreur");
    int stationCount = listStation != null ? listStation.size() : 0;
    int ApproCount = listeAppro != null ? listeAppro.size() : 0;
    int venteCount = listeVente != null ? listeVente.size() : 0;
%>
<!-- Main Content -->
<div class="content flex-grow overflow-auto">
    <%@include file="/layout/topNavigation.jsp" %>
    <!-- Dashboard Content -->
    <main class="p-6">
        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <a href="${pageContext.request.contextPath}/StationServlet" class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600 mr-4">
                        <i class="fas fa-gas-pump text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Stations</p>
                        <h3 class="text-2xl font-bold"><%= stationCount%></h3>
                    </div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100 text-green-600 mr-4">
                        <i class="fas fa-truck text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Approvisionnements</p>
                        <h3 class="text-2xl font-bold"><%= ApproCount%></h3>
                    </div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/VenteServlet" class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100 text-purple-600 mr-4">
                        <i class="fas fa-shopping-cart text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Ventes</p>
                        <h3 class="text-2xl font-bold"><%= venteCount%></h3>
                    </div>
                </div>
            </a>
            <div class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-yellow-100 text-yellow-600 mr-4">
                        <i class="fas fa-dollar-sign text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Revenus</p>
                        <h3 class="text-2xl font-bold">HTG <%= totalRevenu%></h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stations Status -->
        <div class="bg-white rounded-lg shadow mb-8">
            <div class="p-4 border-b">
                <h2 class="text-lg font-semibold text-gray-800">Statut des Stations</h2>
            </div>
            <div class="p-4 overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Station</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Adresse</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gazoline</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Diesel</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <%
                            for (StationModel station : listStation) {
                                // Calcul des pourcentages
                                double pourcentageGazoline = (station.getCapaciteGazoline() > 0)
                                        ? Math.round((station.getQuantiteGazoline() * 100.0 / station.getCapaciteGazoline()) * 10) / 10.0 : 0;
                                double pourcentageDiesel = (station.getCapaciteDiesel() > 0)
                                        ? Math.round((station.getQuantiteDiesel() * 100.0 / station.getCapaciteDiesel()) * 10) / 10.0 : 0;

                                // Couleurs en fonction du niveau
                                String gazolineColor = pourcentageGazoline < 20 ? "text-red-600" : "text-green-600";
                                String dieselColor = pourcentageDiesel < 20 ? "text-red-600" : "text-green-600";
                                String gazolineBarColor = pourcentageGazoline < 20 ? "bg-red-500" : "bg-green-500";
                                String dieselBarColor = pourcentageDiesel < 20 ? "bg-red-500" : "bg-green-500";
                        %>
                        <tr class="hover:bg-gray-50 transition-colors duration-150">
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-gas-pump text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900"><%= station.getNumero()%></div>
                                        <div class="text-sm text-gray-500"><%= station.getCommune()%></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900"><%= station.getRue()%></div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span class="<%= gazolineColor%> font-medium"><%= pourcentageGazoline%>%</span>
                                        <span class="text-gray-500">
                                            <%= station.getQuantiteGazoline()%>/<%= station.getCapaciteGazoline()%> gal
                                        </span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2 mt-1">
                                        <div class="h-2 rounded-full <%= gazolineBarColor%>" 
                                             style="width: <%= pourcentageGazoline%>%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span class="<%= dieselColor%> font-medium"><%= pourcentageDiesel%>%</span>
                                        <span class="text-gray-500">
                                            <%= station.getQuantiteDiesel()%>/<%= station.getCapaciteDiesel()%> gal
                                        </span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-2 mt-1">
                                        <div class="h-2 rounded-full <%= dieselBarColor%>" 
                                             style="width: <%= pourcentageDiesel%>%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                <a href="${pageContext.request.contextPath}/StationServlet?action=edit&id=<%= station.getId()%>" 
                                   class="text-blue-600 hover:text-blue-900 mr-4">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/StationServlet?action=delete&id=<%= station.getId()%>" 
                                   class="text-red-600 hover:text-red-900" 
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette station ?');">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    // Toggle sidebar on mobile
    document.getElementById('mobileToggle').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('show');
    });
</script>
<%@ include file="/layout/footer.jsp" %>
