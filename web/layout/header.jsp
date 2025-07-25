<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion Stations</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome pour l'icône hamburger -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 text-gray-800">
    <header class="bg-white text-blue-800 border-b-4 border-blue-800 shadow-sm">
        <div class="container mx-auto px-4 py-5">
            <nav class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Station Manager</h1>
                
                <!-- Menu pour desktop (visible à partir de md) -->
                <ul class="hidden md:flex space-x-8">
                    <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:underline font-medium">Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:underline font-medium">Stations</a></li>
                    <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:underline font-medium">Approvisionnements</a></li>
                    <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:underline font-medium">Ventes</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline font-medium">Déconnexion</a></li>
                </ul>
                
                <!-- Bouton hamburger pour mobile (visible en dessous de md) -->
                <button id="hamburger-button" class="md:hidden text-blue-800 focus:outline-none">
                    <i class="fas fa-bars text-2xl"></i>
                </button>
            </nav>
            
            <!-- Menu mobile (caché par défaut) -->
            <div id="mobile-menu" class="hidden md:hidden py-4">
                <ul class="flex flex-col space-y-4">
                    <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="block hover:underline font-medium">Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/StationServlet" class="block hover:underline font-medium">Stations</a></li>
                    <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="block hover:underline font-medium">Approvisionnements</a></li>
                    <li><a href="${pageContext.request.contextPath}/VenteServlet" class="block hover:underline font-medium">Ventes</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="block hover:underline font-medium">Déconnexion</a></li>
                </ul>
            </div>
        </div>
    </header>

    <script>
        // Gestion du menu hamburger
        const hamburgerButton = document.getElementById('hamburger-button');
        const mobileMenu = document.getElementById('mobile-menu');
        
        hamburgerButton.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
            
            // Changer l'icône entre hamburger et croix
            const icon = hamburgerButton.querySelector('i');
            if (mobileMenu.classList.contains('hidden')) {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            } else {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            }
        });
    </script>
</body>
</html>




<!--<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion Stations</title>
     Tailwind CSS 
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

</head>
<body class="bg-gray-100 text-gray-800">
    <header class="bg-blue-800 text-white shadow">
        <div class="container mx-auto px-4 py-4">
            <nav class="flex items-center justify-between">
                <h1 class="text-xl font-bold">Station Manager</h1>
                <ul class="flex space-x-6">
                    <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:underline">Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:underline">Stations</a></li>
                    <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:underline">Approvisionnements</a></li>
                    <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:underline">Ventes</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline">D?connexion</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>-->

<!--Header bg white-->
<!--<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion Stations</title>
     Tailwind CSS 
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100 text-gray-800">
    <header class="bg-white text-blue-800 border-b-4 border-blue-800 shadow-sm">
        <div class="container mx-auto px-4 py-5">  py-5 augmente la hauteur 
            <nav class="flex items-center justify-between">
                <h1 class="text-2xl font-bold">Station</h1>  text-xl -> text-2xl 
                <ul class="flex space-x-8">  space-x-6 -> space-x-8 
                    <li><a href="${pageContext.request.contextPath}/dashboard.jsp" class="hover:underline font-medium">Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/StationServlet" class="hover:underline font-medium">Stations</a></li>
                    <li><a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="hover:underline font-medium">Approvisionnements</a></li>
                    <li><a href="${pageContext.request.contextPath}/VenteServlet" class="hover:underline font-medium">Ventes</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline font-medium">Déconnexion</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>-->
