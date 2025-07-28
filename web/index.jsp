
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestion des Stations d'Essence | ABB Group</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#0056b3',
                            secondary: '#d82b1e',
                            univ: {
                                blue: '#0056b3',
                                red: '#d82b1e',
                            }
                        }
                    }
                }
            }
        </script>
        <style type="text/tailwindcss">
            @layer utilities {
                .gradient-bg {
                    @apply bg-gradient-to-r from-primary to-secondary;
                }
                .card-hover {
                    @apply transition-all duration-300 hover:-translate-y-1 hover:shadow-lg;
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans antialiased">
        <!-- Header -->
        <header class="gradient-bg text-white shadow-md">
            <div class="container mx-auto px-4 py-8 text-center">
                <h1 class="text-4xl font-bold mb-2">Gestion Centralisée des Stations d'Essence</h1>
                <p class="text-xl">Projet de Développement Web - 4ème Année Informatique</p>
            </div>
        </header>

        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            <!-- Project Description -->
            <section class="bg-blue-50 border-l-4 border-secondary p-6 rounded-lg mb-12">
                <h2 class="text-3xl font-semibold text-primary mb-4">Description du Projet</h2>
                <p class="text-gray-700 text-lg leading-relaxed">
                    Cette application web centralisée développée avec Jakarta EE et MySQL permet la gestion opérationnelle 
                    des stations-service situées au Cap-Haïtien, Limonade, Terrier-Rouge et Fort-Liberté. 
                    Elle offre un suivi efficace des activités quotidiennes incluant l'approvisionnement 
                    et la vente de carburant (gazoline et diesel).
                </p>
            </section>

            <!-- Features -->
            <section class="mb-16">
                <h2 class="text-3xl font-semibold text-primary mb-8 text-center">Fonctionnalités Principales</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <!-- Feature 1 -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="text-primary mb-4">
                                <i class="fas fa-gas-pump text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3">Gestion des Stations</h3>
                            <ul class="text-gray-600 space-y-2">
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Ajout et modification des stations</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Suivi des capacités de stockage</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Visualisation des quantités disponibles</span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Feature 2 -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="text-primary mb-4">
                                <i class="fas fa-truck text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3">Approvisionnement</h3>
                            <ul class="text-gray-600 space-y-2">
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Enregistrement des livraisons</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Mise à jour automatique des stocks</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Historique des fournisseurs</span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Feature 3 -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="text-primary mb-4">
                                <i class="fas fa-cash-register text-4xl"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-3">Gestion des Ventes</h3>
                            <ul class="text-gray-600 space-y-2">
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Saisie des transactions</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Calcul automatique des revenus</span>
                                </li>
                                <li class="flex items-start">
                                    <i class="fas fa-check-circle text-secondary mt-1 mr-2"></i>
                                    <span>Rapports de performance</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Tech Stack -->
            <section class="bg-blue-50 rounded-xl p-8 mb-16">
                <h2 class="text-3xl font-semibold text-primary mb-8 text-center">Technologies Utilisées</h2>
                <div class="flex flex-wrap justify-center gap-12">
                    <div class="text-center">
                        <div class="bg-white p-4 rounded-full shadow-md inline-block mb-2">
                            <i class="fab fa-java text-5xl text-primary"></i>
                        </div>
                        <p class="font-medium">Java EE</p>
                    </div>
                    <div class="text-center">
                        <div class="bg-white p-4 rounded-full shadow-md inline-block mb-2">
                            <i class="fas fa-database text-5xl text-primary"></i>
                        </div>
                        <p class="font-medium">MySQL</p>
                    </div>
                    <div class="text-center">
                        <div class="bg-white p-4 rounded-full shadow-md inline-block mb-2">
                            <i class="fab fa-microsoft text-5xl text-primary"></i>
                        </div>
                        <p class="font-medium">Jakarta EE</p>
                    </div>
                    <div class="text-center">
                        <div class="bg-white p-4 rounded-full shadow-md inline-block mb-2">
                            <i class="fab fa-html5 text-5xl text-primary"></i>
                        </div>
                        <p class="font-medium">HTML5</p>
                    </div>
                    <div class="text-center">
                        <div class="bg-white p-4 rounded-full shadow-md inline-block mb-2">
                            <i class="fab fa-css3-alt text-5xl text-primary"></i>
                        </div>
                        <p class="font-medium">CSS3</p>
                    </div>
                </div>
            </section>

            <!-- Section de l'Equipe -->
            <section class="text-center mb-16">
                <h2 class="text-3xl font-semibold text-primary mb-4">Notre Équipe - Groupe ABB</h2>
                <p class="text-gray-600 mb-12 max-w-2xl mx-auto">
                    Étudiants en Sciences Informatiques à l'Université d'État d'Haïti, Campus Henry Christophe, Limonade
                </p>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <!-- Albikendy JEAN -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="w-32 h-32 mx-auto mb-4 rounded-full bg-blue-100 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/Albikendy.jpg" 
                                     alt="Bendy SERVILUS"
                                     class="w-full h-full object-cover rounded-full"/>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Bendy SERVILUS</h3>
                            <p class="text-secondary font-medium mb-2">Développeur</p>
                            <p class="text-gray-600">Spécialiste Java EE</p>
                            <div class="mt-4 flex justify-center space-x-4">
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-github"></i>
                                </a>
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-linkedin"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Bendy SERVILUS -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="w-32 h-32 mx-auto mb-4 rounded-full bg-blue-100 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/Bendy.jpg" 
                                     alt="Bendy SERVILUS"
                                     class="w-full h-full object-cover rounded-full"/>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Bendy SERVILUS</h3>
                            <p class="text-secondary font-medium mb-2">Développeur</p>
                            <p class="text-gray-600">Spécialiste Java EE</p>
                            <div class="mt-4 flex justify-center space-x-4">
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-github"></i>
                                </a>
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-linkedin"></i>
                                </a>
                            </div>
                        </div>
                    </div>


                    <!-- Blemy JOSEPH -->
                    <div class="bg-white rounded-xl shadow-md overflow-hidden card-hover">
                        <div class="p-6">
                            <div class="w-32 h-32 mx-auto mb-4 rounded-full bg-blue-100 overflow-hidden">
                                <img src="${pageContext.request.contextPath}/assets/Blemy.jpg" 
                                     alt="Bendy SERVILUS"
                                     class="w-full h-full object-cover rounded-full"/>
                            </div>
                            <h3 class="text-xl font-bold mb-2">Bendy SERVILUS</h3>
                            <p class="text-secondary font-medium mb-2">Développeur</p>
                            <p class="text-gray-600">Spécialiste Java EE</p>
                            <div class="mt-4 flex justify-center space-x-4">
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-github"></i>
                                </a>
                                <a href="#" class="text-blue-500 hover:text-blue-700">
                                    <i class="fab fa-linkedin"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-12">
                    <a href="${pageContext.request.contextPath}/LoginServlet" class="inline-block gradient-bg text-white font-bold py-3 px-8 rounded-full shadow-lg hover:shadow-xl transition duration-300">
                        Accéder à l'Application <i class="fas fa-arrow-right ml-2"></i>
                    </a>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-8">
            <div class="container mx-auto px-4 text-center">
                <div class="flex justify-center space-x-6 mb-4">

                    <a href="https://github.com/Mr-Albe/ABB_jakartaeeWeb.git" class="text-gray-300 hover:text-white">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
                <p class="mb-2">&copy; 2024-2025 Groupe ABB - Université d'État d'Haïti</p>
                <p>Projet de Développement Web en Java - 4ème Année Informatique</p>
            </div>
        </footer>
    </body>
</html>


