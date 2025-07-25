<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.StationModel" %>
<%@ include file="/layout/header.jsp" %>
<%
    StationModel station = (StationModel) request.getAttribute("station");
    if (station == null) {
        station = new StationModel();
    }
    
    String error = (String) request.getAttribute("error");
    boolean isEdit = station != null;
%>

<div class="max-w-4xl mx-auto px-4 py-8">
    <div class="bg-white shadow rounded-lg p-6">
        <h2 class="text-2xl font-bold text-gray-800 mb-6"><%= isEdit ? "Modifier" : "Ajouter" %> une station</h2>
        
        <% if (error != null) { %>
            <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700"><%= error %></p>
                    </div>
                </div>
            </div>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/StationServlet" class="space-y-6">
            <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
            
            <% if (isEdit) { %>
                <input type="hidden" name="id" value="<%= station.getId()%>">
            <% } %>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <!-- Colonne 1 -->
                <div class="space-y-4">
                    <div>
                        <label for="numero" class="block text-sm font-medium text-gray-700 mb-1">Numéro</label>
                        <input type="hidden" id="numero" name="numero" 
                               value="<%= isEdit ? station.getNumero() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                    
                    <div>
                        <label for="rue" class="block text-sm font-medium text-gray-700 mb-1">Rue</label>
                        <input type="text" id="rue" name="rue" 
                               value="<%= isEdit ? station.getRue() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                    
                    <div>
                        <label for="commune" class="block text-sm font-medium text-gray-700 mb-1">Commune</label>
                        <input type="text" id="commune" name="commune" 
                               value="<%= isEdit ? station.getCommune() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                </div>
                
                <!-- Colonne 2 -->
                <div class="space-y-4">
                    <div>
                        <label for="capaciteGazoline" class="block text-sm font-medium text-gray-700 mb-1">Capacité Gazoline</label>
                        <input type="number" id="capaciteGazoline" name="capaciteGazoline" min="1"
                               value="<%= isEdit ? station.getCapaciteGazoline() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                    
                    <div>
                        <label for="quantiteGazoline" class="block text-sm font-medium text-gray-700 mb-1">Quantité Gazoline</label>
                        <input type="number" id="quantiteGazoline" name="quantiteGazoline" min="0"
                               value="<%= isEdit ? station.getQuantiteGazoline() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                    
                    <div>
                        <label for="capaciteDiesel" class="block text-sm font-medium text-gray-700 mb-1">Capacité Diesel</label>
                        <input type="number" id="capaciteDiesel" name="capaciteDiesel" min="1"
                               value="<%= isEdit ? station.getCapaciteDiesel() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                    
                    <div>
                        <label for="quantiteDiesel" class="block text-sm font-medium text-gray-700 mb-1">Quantité Diesel</label>
                        <input type="number" id="quantiteDiesel" name="quantiteDiesel" min="0"
                               value="<%= isEdit ? station.getQuantiteDiesel() : "" %>"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               required>
                    </div>
                </div>
            </div>
            
            <div class="flex justify-end space-x-4 pt-4">
                <a href="StationServlet" class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    Annuler
                </a>
                <button type="submit" class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const capGaz = parseInt(document.getElementById('capaciteGazoline').value);
        const qteGaz = parseInt(document.getElementById('quantiteGazoline').value);
        const capDie = parseInt(document.getElementById('capaciteDiesel').value);
        const qteDie = parseInt(document.getElementById('quantiteDiesel').value);
        
        if (qteGaz > capGaz) {
            alert('La quantité Gazoline ne peut pas dépasser la capacité');
            e.preventDefault();
            return false;
        }
        
        if (qteDie > capDie) {
            alert('La quantité Diesel ne peut pas dépasser la capacité');
            e.preventDefault();
            return false;
        }
        
        return true;
    });
</script>

<%@ include file="/layout/footer.jsp" %>