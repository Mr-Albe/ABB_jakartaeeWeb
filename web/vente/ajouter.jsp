<%@page import="java.time.LocalDate"%>
<%@page import="model.VenteModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%    List<StationModel> listStation = new ArrayList<>();
    VenteModel vente = (VenteModel) request.getAttribute("vente");

    if (vente == null) {
        vente = new VenteModel();
    }
    
    boolean isvente = vente.getQuantite() > 0;

    String error = null;
    if (session.getAttribute("erreur") != null) {
        error = (String) session.getAttribute("erreur");
    }

    try {
        StationDao stationDao = new StationDao();
        listStation = stationDao.afficherTout();
    } catch (Exception e) {
        error = "Erreur lors du chargement des stations : " + e.getMessage();
    }
%>

<div class="content flex-1 overflow-auto">
    <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-12 px-4 sm:px-10 lg:px-8">
        <div class="max-w-4xl mx-auto">
            <!-- Carte avec exactement les mêmes dimensions que le formulaire d'approvisionnement -->
            <div class="bg-white/80 backdrop-blur-lg rounded-2xl shadow-xl overflow-hidden border border-white/30 transition-all duration-300 hover:shadow-2xl">
                <!-- En-tête identique -->
                <div class="bg-gradient-to-r from-blue-600 to-indigo-700 px-6 py-5 sm:px-8 sm:py-6 relative overflow-hidden">
                    <div class="absolute inset-0 bg-gradient-to-r from-white/10 to-white/0"></div>
                    <h2 class="text-2xl font-bold text-white relative z-10 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        Nouvelle Vente
                    </h2>
                </div>

                <%-- Affichage des erreurs identique --%>
                <% if (error != null && !error.isEmpty()) {%>
                <div class="mb-8 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fade-in">
                    <div class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                        <div class="text-sm text-red-700 font-medium"><%= error%></div>
                    </div>
                </div>
                <% session.removeAttribute("error");
                }%>

                <!-- Contenu du formulaire avec même structure et espacement -->
                <div class="px-6 py-8 sm:px-8 sm:py-10">
                    <form action="<%= request.getContextPath()%>/VenteServlet" method="post" class="space-y-6" id="venteForm">
                        <input type="hidden" name="action" value="add">

                            <!-- Grille responsive identique -->
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Colonne de gauche - mêmes dimensions -->
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Station - même champ que l'approvisionnement -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Station</label>
                                        <div class="relative">
                                            <select name="num_station" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                                <%if (isvente) {%>
                                                <option value="<%= vente.getNumStation()%>" selected ><%= vente.getNumStation()%></option>
                                                <%}%>
                                                <option value="" disabled >Sélectionnez la station...</option>
                                                <% for (StationModel st : listStation) {%>  
                                                <option value="<%= st.getNumero()%>"><%= st.getNumero()%> - <%= st.getCommune()%></option>
                                                <% }%>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Type carburant - même champ -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Type de carburant</label>
                                        <select name="type_carburant" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                            <%if (isvente) {%>
                                            <option value="<%= vente.getTypeCarburant()%>" selected ><%=vente.getTypeCarburant()%></option>
                                            <%}%>
                                            <option value="" disabled selected>Sélectionnez...</option>
                                            <option value="gazoline">⛽ Gazoline</option>
                                            <option value="diesel">⛽ Diesel</option>
                                        </select>
                                    </div>

                                    <!-- Quantité - même espacement -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Quantité (gallons)</label>
                                        <input type="number" name="quantite" min="0.01" max="50000000" step="0.01" required 
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200 calculate-revenue"
                                               value="<%= isvente ? vente.getQuantite() : 1%>"
                                               >
                                    </div>

                                    <!-- Prix unitaire  -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Prix unitaire (HTG)</label>
                                        <input type="number" name="prix_vente" min="0.01" step="0.01" required 
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200 calculate-revenue"
                                               value="<%= isvente ? vente.getPrixUnitaire() : 0 %>"
                                        >
                                    </div>
                                </div>

                                <!--  -->
                                <div class="space-y-6">
                                    <!-- Date - même champ -->
                                    <div class="space-y-2">
                                        <label class="block text-sm font-medium text-gray-700">Date de vente</label>
                                        <input type="date" name="date_vente" max="<%= java.time.LocalDate.now()%>" required 
                                               class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm"
                                               value="<%= isvente ? vente.getDateVente().toString() : LocalDate.now().toString() %>"
                                               >
                                    </div>

                                    <!-- Revenu calculé - occupe l'espace du fournisseur -->
                                    <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-lg" style="margin-top: 1.5rem;">
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM7 9a1 1 0 100-2 1 1 0 000 2zm7-1a1 1 0 11-2 0 1 1 0 012 0zm-.464 5.535a1 1 0 10-1.415-1.414 3 3 0 01-4.242 0 1 1 0 00-1.415 1.414 5 5 0 007.072 0z" clip-rule="evenodd" />
                                            </svg>
                                            <div>
                                                <p class="text-sm font-medium text-blue-800">Revenu estimé</p>
                                                <p class="text-2xl font-bold text-blue-600" id="revenu-estime">0.00 HTG</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Bouton -->
                            <div class="pt-4">
                                <button type="submit" class="w-full flex justify-center items-center px-6 py-4 bg-gradient-to-r from-blue-600 to-indigo-700 hover:from-blue-700 hover:to-indigo-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                                    </svg>
                                    Enregistrer la vente
                                </button>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.getElementById('venteForm');
        const quantiteInput = form.querySelector('input[name="quantite"]');
        const prixInput = form.querySelector('input[name="prix_vente"]');
        const revenuEstime = document.getElementById('revenu-estime');

        function calculerRevenu() {
            const quantite = parseFloat(quantiteInput.value) || 0;
            const prix = parseFloat(prixInput.value) || 0;
            revenuEstime.textContent = (quantite * prix).toFixed(2) + ' HTG';
        }

        form.querySelectorAll('.calculate-revenue').forEach(input => {
            input.addEventListener('input', calculerRevenu);
        });
    });
</script>

<%@ include file="/layout/footer.jsp" %>







<%--<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/layout/isConnect.jsp"  %>

<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<%  
    List<StationModel> listStation = new ArrayList<>();
    String error = null;

    if (session.getAttribute("error") != null) {
        error = (String) session.getAttribute("error");
    }

    try {
        StationDao stationDao = new StationDao();
        listStation = stationDao.afficherTout();
    } catch (Exception e) {
        error = "Erreur lors du chargement des stations : " + e.getMessage();
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
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                        Nouvelle Vente
                    </h2>
                </div>
                
                 Affichage des erreurs 
                <% if (error != null && !error.isEmpty()) {%>
                <div class="mb-8 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg animate-fade-in">
                    <div class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500 mr-3" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                        <div class="text-sm text-red-700 font-medium"><%= error%></div>
                    </div>
                </div>
                <% session.removeAttribute("error"); }%>

                <!-- Form content -->
                <div class="px-6 py-8 sm:px-8 sm:py-10">
                    <form action="<%= request.getContextPath()%>/VenteServlet" method="post" class="space-y-6" id="venteForm">
                        <input type="hidden" name="action" value="enregistrer">

                        <!-- Responsive grid -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Left column -->
                            <div class="space-y-6">
                                <!-- Champ Station -->
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-gray-700">Station</label>
                                    <div class="relative">
                                        <select name="id_station" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                            <option value="" disabled selected>Sélectionnez la station...</option>
                                            <% for (StationModel st : listStation) {%>  
                                            <option value="<%= st.getNumero()%>"><%= st.getNumero()%> - <%= st.getCommune()%></option>
                                            <% }%>
                                        </select>
                                    </div>
                                </div>

                                <!-- Champ Type de carburant -->
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-gray-700">Type de carburant</label>
                                    <select name="type_carburant" required class="w-full pl-3 pr-10 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm appearance-none bg-white bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj48cG9seWxpbmUgcG9pbnRzPSI2IDkgMTIgMTUgMTggOSI+PC9wb2x5bGluZT48L3N2Zz4=')] bg-no-repeat bg-[right_0.75rem_center] bg-[length:1.5em]">
                                        <option value="" disabled selected>Sélectionnez...</option>
                                        <option value="gazoline">⛽ Gazoline</option>
                                        <option value="diesel">⛽ Diesel</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Right column -->
                            <div class="space-y-6">
                                <!-- Champ Quantité -->
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-gray-700">Quantité (gallons)</label>
                                    <input type="number" name="quantite" min="1" step="0.01" required 
                                           class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200 calculate-revenue">
                                </div>

                                <!-- Champ Prix de vente -->
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-gray-700">Prix unitaire (HTG)</label>
                                    <input type="number" name="prix_vente" min="0.01" step="0.01" required 
                                           class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm transition duration-200 calculate-revenue">
                                </div>

                                <!-- Champ Date -->
                                <div class="space-y-2">
                                    <label class="block text-sm font-medium text-gray-700">Date de vente</label>
                                    <input type="date" name="date_vente" max="<%= java.time.LocalDate.now()%>" required 
                                           class="w-full px-4 py-3 text-base border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent rounded-lg shadow-sm">
                                </div>
                            </div>
                        </div>

                        <!-- Revenu calculé -->
                        <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-lg">
                            <div class="flex items-center">
                                <div>
                                    <p class="text-sm font-medium text-blue-800">Revenu estimé </p>
                                    <p class="text-2xl font-bold text-blue-600" id="revenu-estime">0.00 HTG</p>
                                </div>
                            </div>
                        </div>

                        <!-- Bouton de soumission -->
                        <div class="pt-4">
                            <button type="submit" class="w-full flex justify-center items-center px-6 py-4 bg-gradient-to-r from-blue-600 to-indigo-700 hover:from-blue-700 hover:to-indigo-800 text-white font-medium rounded-lg shadow-md hover:shadow-lg transform hover:-translate-y-0.5 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4" />
                                </svg>
                                Enregistrer la vente
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('venteForm');
    const quantiteInput = form.querySelector('input[name="quantite"]');
    const prixInput = form.querySelector('input[name="prix_vente"]');
    const revenuEstime = document.getElementById('revenu-estime');
    
    // Fonction de calcul du revenu
    function calculerRevenu() {
        const quantite = parseFloat(quantiteInput.value) || 0;
        const prix = parseFloat(prixInput.value) || 0;
        const revenu = quantite * prix;
        revenuEstime.textContent = revenu.toFixed(2) + ' HTG';
    }
    
    // Écouteurs d'événements pour les champs de calcul
    form.querySelectorAll('.calculate-revenue').forEach(input => {
        input.addEventListener('input', calculerRevenu);
    });
    
    // Calcul initial
    calculerRevenu();
});
</script>

<%@ include file="/layout/footer.jsp" %>--%>






<%--<%@page import="java.util.ArrayList"%>
<%@page import="model.StationModel"%>
<%@page import="java.util.List"%>
<%@page import="serviceImplement.StationDao"%>
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


 Affichage des erreurs 
<% if (error != null && !error.isEmpty()){%>
<div  style="color: red; background-color: #fee; padding: 10px; border: 1px solid red; margin-bottom: 10px;"">

    <h3><%= error%></h3>

</div><hr>
<%}%>

<h3>Effectuez Nouvelle vente</h3>

<form action="${pageContext.request.contextPath}/VenteServlet" method="post">

    <div class="form-group">
        <label>ID Station:</label>
        <select name="idStation">
            <% for( StationModel station : listStation){ %>
            <option value="<%=station.getId()%>"><%=station.getId()%></option>
          <% }  %>
        
        </select>
    </div>

    <div class="form-group">
        <label>Type de carburant:</label>
        <select name="typeCarburant">
            <option value="gazoline">Gazoline</option>
            <option value="diesel">Diesel</option>
        </select><br>
    </div>

    <div class="form-group">
        <label>Quantité Gallons</label>
        <input type="number" name="quantite" min="1" required>
    </div>

    <div class="form-group">
        <label>Prix unitaire en Gourdes:</label>
        <input type="number" step="0.01" name="prixUnitaire" required>
    </div>

    <div class="form-group">
        <label>Date de vente:</label>
        <input type="date" name="dateVente" max="<%= java.time.LocalDate.now()%>" required>
    </div>

    <div class="form-group">
        <button type="submit">Valider</button>
    </div>
   
</form>

<%@ include file="/layout/footer.jsp" %>--%>