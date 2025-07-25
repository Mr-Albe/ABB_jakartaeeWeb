<hr class="border-t border-gray-300 my-8">

<footer class="bg-blue-900 text-white py-4">
    <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-6">

        <!-- Projet -->
        <div>
            <h2 class="text-xl font-bold mb-4">� propos</h2>
            <p class="text-sm space-y-2">
                Ce projet JakartaEE a �t� r�alis� dans le cadre du cours de d�veloppement web pour la 4e INFO � CHC-UEHL.
            </p>
        </div>

        <!-- Navigation -->
        <div>
            <h2 class="text-xl font-bold mb-4">Navigation</h2>
            <ul class="text-sm space-y-2">
                <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:underline">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:underline">Stations</a></li>
                <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:underline">Approvisionnements</a></li>
                <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:underline">Ventes</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline">D�connexion</a></li>
            </ul>
        </div>

        <!-- Contact -->
        <div>
            <h2 class="text-xl font-bold mb-4">Contact</h2>
            <ul class="text-sm space-y-2">
                <li>Email : <a href="mailto:info@chc-uehl.edu" class="hover:underline">info@chc-uehl.edu</a></li>
                <li>T�l�phone : +509 1234 5678</li>
                <li>Adresse : Cap-Ha�tien, Ha�ti</li>
            </ul>
        </div>

        <!-- R�seaux -->
        <div>
            <h2 class="text-xl font-bold mb-4">R�seaux sociaux</h2>
            <ul class="text-sm space-y-2">
                <li><a href="#" class="hover:underline">Facebook</a></li>
                <li><a href="#" class="hover:underline">LinkedIn</a></li>
                <li><a href="#" class="hover:underline">GitHub</a></li>
            </ul>
        </div>

    </div>

    <div class="border-t border-gray-600 mt-10 pt-6 text-center text-sm text-gray-300">
        &copy; 2025 | Projet JakartaEE | 4e INFO - CHC/UEHL. Tous droits r�serv�s.
    </div>
    <script src="https://cdn.tailwindcss.com"></script>
</footer>
