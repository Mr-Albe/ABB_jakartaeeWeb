<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.StationModel" %>
<%@include file="/layout/isConnect.jsp" %>
<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%
    StationModel station = (StationModel) request.getAttribute("station");
    if (station == null) {
        station = new StationModel();
    }
    
    String error = (String) request.getAttribute("erreur");
    boolean isEdit = station.getId() != 0;
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
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                    <%= isEdit ? "Modifier la station" : "Nouvelle station" %>
                </h2>
            </div>
            
            <%-- Affichage des erreurs --%>
            <% if (error != null && !error.isEmpty()) { %>
            <div class="mb-8 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fade-in mx-6 mt-6">
                <div class="flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                    </svg>
                    <div class="text-sm text-red-700 font-medium"><%= error %></div>
                </div>
            </div>
            <% } %>

            <!-- Form content -->
            <div class="px-6 py-8 sm:px-8 sm:py-10">
                <form method="post" action="${pageContext.request.contextPath}/StationServlet" class="space-y-6">
                    <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
                    
                    <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= station.getId() %>">
                    <% } %>
                    
                    <!-- Responsive grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Left column -->
                        <div class="space-y-6">
                            <!-- Champ Numéro -->
                            <div class="space-y-2">
                                <label class="block text-sm font-medium text-gray-700">Numéro de la station*</label>
                                <input type="text" name="numero" 
                                       value="<%= station.getNumero() != null ? station.getNumero() : "" %>"
                                       class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200" 
                                       placeholder="Ex: ST001" required />
                            </div>

                            <!-- Champ Rue -->
                            <div class="space-y-2">
                                <label class="block text-sm font-medium text-gray-700">Rue*</label>
                                <input type="text" name="rue" 
                                       value="<%= station.getRue() != null ? station.getRue() : "" %>"
                                       class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200" 
                                       placeholder="Ex: Rue Saint melon..." required />
                            </div>

                            <!-- Champ Commune -->
                            <div class="space-y-2">
                                <label class="block text-sm font-medium text-gray-700">Commune*</label>
                                <input type="text" name="commune" 
                                       value="<%= station.getCommune() != null ? station.getCommune() : "" %>"
                                       class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200" 
                                       placeholder="Ex: Limonade" required />
                            </div>
                        </div>

                        <!-- Right column -->
                        <div class="space-y-6">
                            <!-- Section Gazoline -->
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <div class="flex items-center mb-3">
                                    <div class="bg-blue-100 p-2 rounded-full mr-3">
                                        <i class="fas fa-fire text-blue-600"></i>
                                    </div>
                                    <h4 class="font-medium text-gray-700">Gazoline</h4>
                                </div>

                                <div class="space-y-4">
                                    <!-- Capacité Gazoline -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Capacité (galons)*</label>
                                        <input type="number" name="capaciteGazoline" min="1"
                                               value="<%= station.getCapaciteGazoline() > 0 ? station.getCapaciteGazoline() : "" %>"
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm" 
                                               placeholder="Ex: 50000" required />
                                    </div>
                                    
                                    <!-- Quantité Gazoline -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Quantité disponible (galons)*</label>
                                        <input type="number" name="quantiteGazoline" min="0"
                                               value="<%= station.getQuantiteGazoline() > 0 ? station.getQuantiteGazoline() : "" %>"
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm" 
                                               placeholder="Ex: 25000" required />
                                    </div>
                                </div>
                            </div>

                            <!-- Section Diesel -->
                            <div class="bg-gray-50 p-4 rounded-lg">
                                <div class="flex items-center mb-3">
                                    <div class="bg-gray-100 p-2 rounded-full mr-3">
                                        <i class="fas fa-oil-can text-gray-600"></i>
                                    </div>
                                    <h4 class="font-medium text-gray-700">Diesel</h4>
                                </div>
                                
                                <div class="space-y-4">
                                    <!-- Capacité Diesel -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Capacité (galons)*</label>
                                        <input type="number" name="capaciteDiesel" min="1"
                                               value="<%= station.getCapaciteDiesel() > 0 ? station.getCapaciteDiesel() : "" %>"
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm" 
                                               placeholder="Ex: 50000" required />
                                    </div>
                                    
                                    <!-- Quantité Diesel -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Quantité disponible (galons)*</label>
                                        <input type="number" name="quantiteDiesel" min="0"
                                               value="<%= station.getQuantiteDiesel() > 0 ? station.getQuantiteDiesel() : "" %>"
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm" 
                                               placeholder="Ex: 25000" required />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Boutons d'action -->
                    <div class="flex flex-col sm:flex-row justify-end space-y-4 sm:space-y-0 sm:space-x-4 pt-4">
                        <a href="${pageContext.request.contextPath}/StationServlet" class="px-6 py-3 border border-gray-300 rounded-lg shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-200 text-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15l-3-3m0 0l3-3m-3 3h8M3 12a9 9 0 1118 0 9 9 0 01-18 0z" />
                            </svg>
                            Annuler
                        </a>
                        <button type="submit" class="px-6 py-3 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-200">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2 inline" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                            </svg>
                            <%= isEdit ? "Mettre à jour" : "Enregistrer" %>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
<%@ include file="/layout/footer.jsp" %>