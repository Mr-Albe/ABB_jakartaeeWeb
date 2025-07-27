<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="/layout/isConnect.jsp"  %>
<%@ include file="/layout/header.jsp" %>
<%@include file="/layout/sidebar.jsp" %>

<!-- Main Content -->
<div class="content flex-grow overflow-auto">
    <%@include file="/layout/topNavigation.jsp" %>
    <!-- Dashboard Content -->
    <main class="p-6">
        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <a href="${pageContext.request.contextPath}/StationServlet" class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-blue-100 text-blue-600 mr-4">
                        <i class="fas fa-gas-pump text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Stations</p>
                        <h3 class="text-2xl font-bold">4</h3>
                    </div>
                </div>
            </a>
                <a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-green-100 text-green-600 mr-4">
                        <i class="fas fa-truck text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Approvisionnements</p>
                        <h3 class="text-2xl font-bold">12</h3>
                    </div>
                </div>
            </a>
            <div class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-purple-100 text-purple-600 mr-4">
                        <i class="fas fa-shopping-cart text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Ventes</p>
                        <h3 class="text-2xl font-bold">156</h3>
                    </div>
                </div>
            </div>
            <div class="dashboard-card bg-white rounded-lg shadow p-6 transition duration-300">
                <div class="flex items-center">
                    <div class="p-3 rounded-full bg-yellow-100 text-yellow-600 mr-4">
                        <i class="fas fa-dollar-sign text-xl"></i>
                    </div>
                    <div>
                        <p class="text-gray-500">Revenus</p>
                        <h3 class="text-2xl font-bold">$24,560</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stations Status -->
        <div class="bg-white rounded-lg shadow mb-8">
            <div class="p-4 border-b">
                <h2 class="text-lg font-semibold text-gray-800">Statut des Stations</h2>
            </div>
            <div class="p-4 overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Station</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Adresse</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gazoline</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Diesel</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-gas-pump text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">ST001</div>
                                        <div class="text-sm text-gray-500">Cap-Haitien</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">123, Rue 18, Cap-Haitien</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>75%</span>
                                        <span>750/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-blue-500" style="width: 75%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>60%</span>
                                        <span>600/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-green-500" style="width: 60%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <button class="text-blue-600 hover:text-blue-900 mr-3">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="text-red-600 hover:text-red-900">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-gas-pump text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">ST002</div>
                                        <div class="text-sm text-gray-500">Limonade</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">456, Av. Liberté, Limonade</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>45%</span>
                                        <span>450/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-blue-500" style="width: 45%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>30%</span>
                                        <span>300/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-green-500" style="width: 30%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <button class="text-blue-600 hover:text-blue-900 mr-3">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="text-red-600 hover:text-red-900">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-gas-pump text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">ST003</div>
                                        <div class="text-sm text-gray-500">Terrier-Rouge</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">789, Rue Principale, Terrier-Rouge</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>85%</span>
                                        <span>850/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-blue-500" style="width: 85%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>70%</span>
                                        <span>700/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-green-500" style="width: 70%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <button class="text-blue-600 hover:text-blue-900 mr-3">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="text-red-600 hover:text-red-900">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <i class="fas fa-gas-pump text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">ST004</div>
                                        <div class="text-sm text-gray-500">Fort-Liberté</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">101, Blvd. Maritime, Fort-Liberté</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>25%</span>
                                        <span>250/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-blue-500" style="width: 25%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="mb-1">
                                    <div class="flex justify-between text-sm">
                                        <span>40%</span>
                                        <span>400/1000 gal</span>
                                    </div>
                                    <div class="progress-bar mt-1">
                                        <div class="progress-fill bg-green-500" style="width: 40%"></div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <button class="text-blue-600 hover:text-blue-900 mr-3">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="text-red-600 hover:text-red-900">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    // Toggle sidebar on mobile
    document.getElementById('mobileToggle').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('show');
    });
</script>
<%@ include file="/layout/footer.jsp" %>
