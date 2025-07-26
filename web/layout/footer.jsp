<footer class="bg-gradient-to-b from-blue-900 to-blue-800 text-white pt-12 pb-6">
    <div class="container mx-auto px-6">
        <!-- Main Footer Content -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-8">
            
            <!-- À propos - Enhanced Card Style -->
            <div class="bg-white/5 rounded-xl p-6 backdrop-blur-sm">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-info-circle mr-3 text-blue-300"></i>
                    À propos
                </h2>
                <p class="text-blue-100 leading-relaxed">
                    Ce projet JakartaEE a été réalisé dans le cadre du cours de développement web 
                    pour la 4e INFO à CHC-UEHL.
                </p>
            </div>

            <!-- Navigation - Interactive Links -->
            <div class="bg-white/5 rounded-xl p-6 backdrop-blur-sm">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <!--<i class="fas fa-compass mr-3 text-blue-300"></i>-->
                    Navigation
                </h2>
                <ul class="space-y-3">
                    <li>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" 
                           class="text-blue-100 hover:text-white transition-all duration-300 flex items-center group">
                           <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 group-hover:mr-4 transition-all"></span>
                           Accueil
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/StationServlet" 
                           class="text-blue-100 hover:text-white transition-all duration-300 flex items-center group">
                           <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 group-hover:mr-4 transition-all"></span>
                           Stations
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/ApprovisionnementServlet" 
                           class="text-blue-100 hover:text-white transition-all duration-300 flex items-center group">
                           <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 group-hover:mr-4 transition-all"></span>
                           Approvisionnements
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/VenteServlet" 
                           class="text-blue-100 hover:text-white transition-all duration-300 flex items-center group">
                           <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 group-hover:mr-4 transition-all"></span>
                           Ventes
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/logout" 
                           class="text-blue-100 hover:text-white transition-all duration-300 flex items-center group">
                           <span class="w-2 h-2 bg-blue-400 rounded-full mr-3 group-hover:mr-4 transition-all"></span>
                           Déconnexion
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Contact - Elegant List -->
            <div class="bg-white/5 rounded-xl p-6 backdrop-blur-sm">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <!--<i class="fas fa-envelope mr-3 text-blue-300"></i>-->
                    Contact
                </h2>
                <ul class="space-y-4">
                    <li class="flex items-start">
                        <div class="bg-blue-700 p-2 rounded-lg mr-3">
                            <i class="fas fa-envelope text-white text-sm"></i>
                        </div>
                        <a href="mailto:info@chc-uehl.edu" class="text-blue-100 hover:text-white transition-colors">
                            info@chc-uehl.edu
                        </a>
                    </li>
                    <li class="flex items-start">
                        <div class="bg-blue-700 p-2 rounded-lg mr-3">
                            <i class="fas fa-phone-alt text-white text-sm"></i>
                        </div>
                        <span class="text-blue-100">+509 1234 5678</span>
                    </li>
                    <li class="flex items-start">
                        <div class="bg-blue-700 p-2 rounded-lg mr-3">
                            <i class="fas fa-map-marker-alt text-white text-sm"></i>
                        </div>
                        <span class="text-blue-100">Cap-Haïtien, Haïti</span>
                    </li>
                </ul>
            </div>

            <!-- Social Media - Animated Icons -->
            <div class="bg-white/5 rounded-xl p-6 backdrop-blur-sm">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <!--<i class="fas fa-share-alt mr-3 text-blue-300"></i>-->
                    Réseaux sociaux
                </h2>
                <div class="flex space-x-4 mb-4">
                    <a href="#" class="bg-blue-700 hover:bg-white text-white hover:text-blue-800 p-3 rounded-full transition-all duration-300 transform hover:-translate-y-1">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="bg-blue-700 hover:bg-white text-white hover:text-blue-800 p-3 rounded-full transition-all duration-300 transform hover:-translate-y-1">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a href="#" class="bg-blue-700 hover:bg-white text-white hover:text-blue-800 p-3 rounded-full transition-all duration-300 transform hover:-translate-y-1">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
                <p class="text-blue-200 italic text-sm">
                    Suivez-nous pour les dernières actualités et mises à jour.
                </p>
            </div>
        </div>

        <!-- Copyright - Subtle Design -->
        <div class="border-t border-blue-700 pt-6 text-center">
            <div class="text-blue-300 text-sm tracking-wide">
                &copy; 2025 Projet JakartaEE | 4e INFO - CHC/UEHL
            </div>
            <div class="text-blue-400 text-xs mt-1">
                Tous droits réservés
            </div>
        </div>
    </div>
</footer>

<!--<hr class="border-t border-blue-700 my-6">

<footer class="bg-blue-800 text-white py-8">
    <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8">

         À propos 
        <div class="space-y-4">
            <h2 class="text-xl font-bold border-b-2 border-blue-600 pb-2">À propos</h2>
            <p class="text-blue-100">
                Ce projet JakartaEE a été réalisé dans le cadre du cours de développement web pour la 4e INFO à CHC-UEHL.
            </p>
        </div>

         Navigation 
        <div class="space-y-4">
            <h2 class="text-xl font-bold border-b-2 border-blue-600 pb-2">Navigation</h2>
            <ul class="space-y-3 text-blue-100">
                <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:text-white hover:underline transition duration-200">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:text-white hover:underline transition duration-200">Stations</a></li>
                <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:text-white hover:underline transition duration-200">Approvisionnements</a></li>
                <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:text-white hover:underline transition duration-200">Ventes</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="hover:text-white hover:underline transition duration-200">Déconnexion</a></li>
            </ul>
        </div>

         Contact 
        <div class="space-y-4">
            <h2 class="text-xl font-bold border-b-2 border-blue-600 pb-2">Contact</h2>
            <ul class="space-y-3 text-blue-100">
                <li class="flex items-start">
                    <i class="fas fa-envelope mr-2 mt-1 text-blue-300"></i>
                    <a href="mailto:info@chc-uehl.edu" class="hover:text-white hover:underline transition duration-200">info@chc-uehl.edu</a>
                </li>
                <li class="flex items-start">
                    <i class="fas fa-phone-alt mr-2 mt-1 text-blue-300"></i>
                    +509 1234 5678
                </li>
                <li class="flex items-start">
                    <i class="fas fa-map-marker-alt mr-2 mt-1 text-blue-300"></i>
                    Cap-Haïtien, Haïti
                </li>
            </ul>
        </div>

         Réseaux sociaux 
        <div class="space-y-4">
            <h2 class="text-xl font-bold border-b-2 border-blue-600 pb-2">Réseaux sociaux</h2>
            <div class="flex space-x-4">
                <a href="#" class="text-blue-300 hover:text-white transition duration-200 text-2xl">
                    <i class="fab fa-facebook"></i>
                </a>
                <a href="#" class="text-blue-300 hover:text-white transition duration-200 text-2xl">
                    <i class="fab fa-linkedin"></i>
                </a>
                <a href="#" class="text-blue-300 hover:text-white transition duration-200 text-2xl">
                    <i class="fab fa-github"></i>
                </a>
            </div>
            <p class="text-blue-100 pt-2">
                Suivez-nous pour les dernières actualités
            </p>
        </div>

    </div>

    <div class="border-t border-blue-700 mt-8 pt-6 text-center text-blue-200 text-sm">
        &copy; 2025 | Projet JakartaEE | 4e INFO - CHC/UEHL. Tous droits réservés.
    </div>
</footer>-->



<!--<hr class="border-t border-gray-300 my-8">

<footer class="bg-blue-900 text-white py-4">
    <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-6">

         Projet 
        <div>
            <h2 class="text-xl font-bold mb-4">À propos</h2>
            <p class="text-sm space-y-2">
                Ce projet JakartaEE a été réalisé dans le cadre du cours de développement web pour la 4e INFO à CHC-UEHL.
            </p>
        </div>

         Navigation 
        <div>
            <h2 class="text-xl font-bold mb-4">Navigation</h2>
            <ul class="text-sm space-y-2">
                <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:underline">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:underline">Stations</a></li>
                <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:underline">Approvisionnements</a></li>
                <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:underline">Ventes</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline">Déconnexion</a></li>
            </ul>
        </div>

         Contact 
        <div>
            <h2 class="text-xl font-bold mb-4">Contact</h2>
            <ul class="text-sm space-y-2">
                <li>Email : <a href="mailto:info@chc-uehl.edu" class="hover:underline">info@chc-uehl.edu</a></li>
                <li>Téléphone : +509 1234 5678</li>
                <li>Adresse : Cap-Haïtien, Haïti</li>
            </ul>
        </div>

         Réseaux 
        <div>
            <h2 class="text-xl font-bold mb-4">Réseaux sociaux</h2>
            <ul class="text-sm space-y-2">
                <li><a href="#" class="hover:underline">Facebook</a></li>
                <li><a href="#" class="hover:underline">LinkedIn</a></li>
                <li><a href="#" class="hover:underline">GitHub</a></li>
            </ul>
        </div>

    </div>

    <div class="border-t border-gray-600 mt-10 pt-6 text-center text-sm text-gray-300">
        &copy; 2025 | Projet JakartaEE | 4e INFO - CHC/UEHL. Tous droits réservés.
    </div>
    <script src="https://cdn.tailwindcss.com"></script>
</footer>-->
