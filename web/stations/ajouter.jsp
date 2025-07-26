<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<div class="max-w-4xl mx-auto px-4 py-8">

    <!-- Message d'erreur -->
    <%
        String erreur = (String) request.getAttribute("erreur");
        if (erreur != null) {
    %>
        <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6">
            <div class="flex">
                <div class="flex-shrink-0">
                    <svg class="h-5 w-5 text-red-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                    </svg>
                </div>
                <div class="ml-3">
                    <p class="text-sm text-red-700"><%= erreur %></p>
                </div>
            </div>
        </div>
    <% } %>

    <div class="bg-white shadow rounded-lg p-6">
        <h3 class="text-xl font-bold text-gray-800 mb-6">Ajouter une Station</h3>
        
        <form action="${pageContext.request.getContextPath()}/StationServlet" method="post">
            <input type="hidden" name="action" value="add" />
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Colonne 1 -->
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Numéro</label>
                        <input type="text" name="numero" value="<%= request.getAttribute("numero") != null ? request.getAttribute("numero") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Rue</label>
                        <input type="text" name="rue" value="<%= request.getAttribute("rue") != null ? request.getAttribute("rue") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Commune</label>
                        <input type="text" name="commune" value="<%= request.getAttribute("commune") != null ? request.getAttribute("commune") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                </div>
                
                <!-- Colonne 2 -->
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Capacité Gazoline</label>
                        <input type="number" name="capaciteGazoline" min="0" value="<%= request.getAttribute("capaciteGazoline") != null ? request.getAttribute("capaciteGazoline") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Quantité Gazoline Disponible</label>
                        <input type="number" name="quantiteGazoline" min="0" value="<%= request.getAttribute("quantiteGazoline") != null ? request.getAttribute("quantiteGazoline") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Capacité Diesel</label>
                        <input type="number" name="capaciteDiesel" min="0" value="<%= request.getAttribute("capaciteDiesel") != null ? request.getAttribute("capaciteDiesel") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                    
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Quantité Diesel Disponible</label>
                        <input type="number" name="quantiteDiesel" min="0" value="<%= request.getAttribute("quantiteDiesel") != null ? request.getAttribute("quantiteDiesel") : ""%>"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                            required />
                    </div>
                </div>
            </div>
            
            <div class="mt-8">
                <button type="submit"
                    class="w-full md:w-auto px-6 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150">
                    Enregistrer la station
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/layout/footer.jsp" %>