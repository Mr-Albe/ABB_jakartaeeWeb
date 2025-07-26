<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/layout/header.jsp" %>

<%
    List<StationModel> listStation = new ArrayList<>();
    String error = null;

    // Récuperer d'abord l'erreur envoyee par la Servlet
    if (request.getAttribute("erreur") != null) {
        error = (String) request.getAttribute("erreur");
    }

    // Ensuite essayer de charger les stations si aucune erreur n'a encore ete detectee
    if (error == null) {
        try {
            StationDao stationDao = new StationDao();
            listStation = stationDao.afficherTout();
        } catch (Exception e) {
            error = "Erreur lors du chargement des stations : ";
        }
    }
%>

<div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-3xl mx-auto">
    
    <!-- Carte principale avec effet glassmorphisme -->
    <div class="bg-white/80 backdrop-blur-lg rounded-2xl shadow-xl overflow-hidden border border-white/30 transition-all duration-300 hover:shadow-2xl hover:-translate-y-1">
      
      <!-- En-tête avec dégradé -->
      <div class="bg-gradient-to-r from-blue-600 to-indigo-700 px-6 py-5 sm:px-8 sm:py-6 relative overflow-hidden">
        <div class="absolute inset-0 bg-gradient-to-r from-white/10 to-white/0"></div>
        <h2 class="text-2xl font-bold text-white relative z-10 flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
          </svg>
          Nouvel Approvisionnement
        </h2>
      </div>
      
      <!-- Contenu du formulaire -->
      <div class="px-6 py-8 sm:px-8 sm:py-10">
        <%-- Affichage des erreurs --%>
        <% if (error != null && !error.isEmpty()) { %>
        <div class="mb-8 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fade-in">
          <div class="flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
            </svg>
            <div class="text-sm text-red-700 font-medium"><%= error %></div>
          </div>
        </div>
        <% } %>
        
        <form action="<%= request.getContextPath()%>/ApprovisionnementServlet" method="post" class="space-y-6">
          <input type="hidden" name="action" value="enregistrer">
          
          <!-- Grille responsive -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- Champ Station -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700 transition-all duration-200 transform translate-y-0 group-focus-within:-translate-y-1">Station</label>
              <div class="relative">
                <select name="stationId" class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                  <% for (StationModel st : listStation) { %>  
                  <option value="<%= st.getId() %>">Station #<%= st.getId() %> - <%= st.getCommune() %></option>
                  <% } %>
                </select>
              </div>
            </div>
            
            <!-- Champ Type de carburant -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700">Type de carburant</label>
              <select name="type" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                <option value="" disabled selected>Sélectionnez...</option>
                <option value="gazoline">⛽ Gazoline</option>
                <option value="diesel">⛽ Diesel</option>
              </select>
            </div>
            
            <!-- Champ Quantité -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700">Quantité (gallons)</label>
              <input type="number" name="quantite" min="1" required class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200">
            </div>
            
            <!-- Champ Date -->
            <div class="space-y-2">
              <label class="block text-sm font-medium text-gray-700">Date de livraison</label>
              <input type="date" name="dateLivraison" max="<%= java.time.LocalDate.now() %>" required class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm">
            </div>
          </div>
          
          <!-- Champ Fournisseur -->
          <div class="space-y-2">
            <label class="block text-sm font-medium text-gray-700">Fournisseur</label>
            <input type="text" name="fournisseur" required placeholder="Nom du fournisseur" class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200">
          </div>
          
          <!-- Bouton de soumission -->
          <div class="pt-4">
            <button type="submit" class="w-full flex justify-center items-center px-6 py-4 bg-gradient-to-r from-blue-600 to-indigo-700 hover:from-blue-700 hover:to-indigo-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
              </svg>
              Enregistrer l'approvisionnement
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Styles supplémentaires -->
<style>
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .animate-fade-in {
    animation: fadeIn 0.3s ease-out forwards;
  }
  
  /* Effet de vague décoratif optionnel */
  .wave-bg {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100px;
    background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1200 120" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none"><path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" fill="%234361ee" opacity=".1"/><path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" fill="%234361ee" opacity=".2"/></svg>');
    background-size: cover;
    background-repeat: no-repeat;
    z-index: -1;
  }
</style>

<!--  effet de vague -->
<div class="wave-bg"></div>

<%@ include file="/layout/footer.jsp" %>