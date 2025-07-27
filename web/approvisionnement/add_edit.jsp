<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.ApprovisionnementModel"%>
<%@page import="serviceImplement.ApprovisionnementDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%    // Initialisation des variables
    List<StationModel> listStation = new ArrayList<>();
    String error = (String) session.getAttribute("erreur");
    if (error == null) {
        error = (String) session.getAttribute("error");
    }

    ApprovisionnementModel appModel = (ApprovisionnementModel) request.getAttribute("approvisionnement");
    if (appModel == null) {
        appModel = new ApprovisionnementModel();
        // Valeurs par defaut pour nouveau approvisionnement
        appModel.setQuantite(1);
        appModel.setDateLivraison(LocalDate.now());
    }

    boolean isEdit = appModel.getId() != 0;

    // Formatage de la date pour l'input HTML
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String dateValue = appModel.getDateLivraison() != null
            ? appModel.getDateLivraison().format(formatter)
            : LocalDate.now().format(formatter);

    // Chargement des stations
    try {
        StationDao stationDao = new StationDao();
        listStation = stationDao.afficherTout();
    } catch (Exception e) {
        error = "Erreur lors du chargement des stations: " + e.getMessage();
    }
%>

<div class="content flex-1 overflow-auto">
    <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8 px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto">
            <!-- Card with glass effect -->
            <div class="bg-white/80 backdrop-blur-lg rounded-2xl shadow-xl overflow-hidden border border-white/30 transition-all duration-300 hover:shadow-2xl">
                <!-- Header with gradient -->
                <div class="bg-gradient-to-r from-blue-600 to-indigo-700 px-6 py-5 sm:px-8 sm:py-6 relative overflow-hidden">
                    <div class="absolute inset-0 bg-gradient-to-r from-white/10 to-white/0"></div>
                    <h2 class="text-2xl font-bold text-white relative z-10 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <%= isEdit ? "Modifier un approvisionnement" : "Nouvel Approvisionnement"%>
                    </h2>
                </div>
                    
<!--                Affichage des erreurs -->
                <% if (error != null && !error.isEmpty()) {%>
                <div class="mb-8 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fade-in">
                    <div class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                        <div class="text-sm text-red-700 font-medium"><%= error%></div>
                    </div>
                </div>
                <% session.removeAttribute("erreur");
                   session.removeAttribute("error");

                    }%>

                <!-- Form content -->
                <div class="px-6 py-8 sm:px-8 sm:py-10">
                    <form action="${pageContext.request.getContextPath()}/ApprovisionnementServlet" method="post" class="space-y-6">
                        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add"%>"/>
                        <% if (isEdit) {%>
                        <input type="hidden" name="id" value="<%= appModel.getId()%>">
                            <% } %>
                            <!-- Responsive grid -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Left column -->
                                <div class="space-y-6">
                                    <!-- Champ Station -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Station</label>
                                        <div class="relative">
                                            <select name="stationId" class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                                <% if (isEdit) {%>
                                                <option value="<%= appModel.getNumStation()%>" selected><%= appModel.getNumStation()%></option>
                                                <% } else { %>
                                                <option value="" disabled selected>Sélectionnez la station...</option>
                                                <% for (StationModel st : listStation) {%>  
                                                <option value="<%= st.getNumero()%>"><%= st.getNumero()%> - <%= st.getCommune()%></option>
                                                <% } %>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Champ Type de carburant -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Type de carburant</label>
                                        <select name="type" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                            <% if (isEdit) {%>
                                            <option value="<%= appModel.getTypeCarburant()%>" selected><%= appModel.getTypeCarburant()%></option>
                                            <% } else {%>
                                            <option value="" disabled selected>Sélectionnez...</option>
                                            <option value="gazoline">⛽ Gazoline</option>
                                            <option value="diesel">⛽ Diesel</option>
                                            <% }
                                            %>
                                        </select>
                                    </div>
                                </div>

                                <!-- Right column -->
                                <div class="space-y-6">
                                    <!-- Champ Quantité -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Quantité (gallons)</label>
                                        <input type="number" name="quantite" min="1" max="5000000" required class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200"
                                               value="<%= isEdit ? appModel.getQuantite() : 1%>"
                                               >
                                    </div>

                                    <!-- Champ Date de livraison -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Date de livraison</label>
                                        <input type="date" name="dateLivraison" max="<%= java.time.LocalDate.now()%>" required class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm"
                                               value="<%= dateValue%>"
                                               >
                                    </div>

                                    <!-- Champ Fournisseur -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Fournisseur</label>
                                        <input type="text" name="fournisseur" required placeholder="Nom du fournisseur" class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200"
                                               value="<%= isEdit ? appModel.getFournisseur() : ""%>" 
                                               >
                                    </div>
                                </div>
                            </div>

                            <!-- Bouton de soumission -->
                            <div class="pt-4">
                                <button type="submit" class="w-full flex justify-center items-center px-6 py-4 bg-gradient-to-r from-blue-600 to-indigo-700 hover:from-blue-700 hover:to-indigo-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                                    </svg>
                                    <%= isEdit ? "Enregistrer les modifications" : "Enregistrer l'approvisionnement"%>
                                </button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/layout/footer.jsp" %>
