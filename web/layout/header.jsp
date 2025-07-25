<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion Stations</title>
    <!-- Tailwind CSS -->
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
                    <li><a href="${pageContext.request.contextPath}/logout" class="hover:underline">Déconnexion</a></li>
                </ul>
            </nav>
        </div>
    </header>
</body>
</html>
