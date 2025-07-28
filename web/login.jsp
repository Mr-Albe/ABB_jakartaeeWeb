<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Gestion des stations</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(rgba(30, 58, 138, 0.85), rgba(30, 58, 138, 0.85)), 
                        url('<%= request.getContextPath() %>/assets/background.png') no-repeat center center fixed;
            background-size: cover;
            background-attachment: fixed;
        }
        .login-card {
            backdrop-filter: blur(8px);
            background: rgba(255, 255, 255, 0.9);
        }
    </style>
</head>

<body class="min-h-screen flex items-center justify-center p-4">

    <div class="login-card rounded-2xl shadow-2xl overflow-hidden w-full max-w-4xl">
        <div class="flex flex-col md:flex-row">
            <!-- Section Visuelle -->
            <div class="md:w-2/5 bg-blue-800 text-white p-10 flex flex-col justify-center">
                <div class="text-center md:text-left">
                    <h1 class="text-4xl font-bold mb-4">Gestion station</h1>
                    <div class="hidden md:block">
                        <div class="flex items-center mb-3">
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                            </svg>
                            <span>Suivi des approvisionnements</span>
                        </div>
                        <div class="flex items-center mb-3">
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                            </svg>
                            <span>Analyse des ventes</span>
                        </div>
<!--                        <div class="flex items-center">
                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                            <span>Accès sécurisé</span>
                        </div>-->
                    </div>
                </div>
            </div>

            <!-- Formulaire de Connexion -->
            <div class="md:w-3/5 p-10">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-bold text-blue-700">Connexion</h2>
                    <p class="text-gray-600 mt-2">Accédez à votre tableau de bord</p>
                </div>

                <form method="post" action="${pageContext.request.getContextPath()}/LoginServlet" class="space-y-6">
                    <%
                        String error = (String) request.getAttribute("errorLogin");
                        if (error != null) {
                    %>
                    <div class="bg-red-50 border-l-4 border-red-500 p-4">
                        <p class="text-red-700 font-medium"><%= error %></p>
                    </div>
                    <% } %>

                    <div>
                        <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Nom d'utilisateur</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <input type="text" name="username" id="username" required
                                   class="pl-10 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="Entrez votre nom d'utilisateur">
                        </div>
                    </div>

                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mot de passe</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <input type="password" name="password" id="password" required
                                   class="pl-10 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                   placeholder="Entrez votre mot de passe">
                        </div>
                    </div>

                    <div>
                        <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-300">
                            Se connecter
                            <svg class="ml-2 -mr-1 w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                            </svg>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>