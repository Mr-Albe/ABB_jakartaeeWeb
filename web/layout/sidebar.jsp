<%@page import="model.UserModel"%>
<%
    UserModel user = (UserModel) session.getAttribute("user");
%>
<div class="sidebar bg-blue-800 text-white w-64 flex-shrink-0 flex flex-col">
    <div class="p-4 flex items-center">
        <i class="fas fa-gas-pump text-2xl mr-3"></i>
        <span class="logo-text font-bold text-xl">Gestion Stations</span>
        <button id="toggleSidebar" class="ml-auto md:hidden">
            <i class="fas fa-times"></i>
        </button>
    </div>
    <div class="flex-grow overflow-y-auto">
        <nav class="p-4">
            <div class="mb-8">
                <p class="text-blue-200 uppercase text-xs font-bold mb-2 nav-text">Menu Principal</p>

                <!-- Tableau de bord -->
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="nav-item flex items-center py-2 px-3 rounded hover:bg-blue-700 mb-1 active">
                    <i class="fas fa-tachometer-alt mr-3"></i>
                    <span class="nav-text">Tableau de bord</span>
                </a>


                <div class="mb-1">
                    <button class="dropdown-btn flex items-center w-full py-2 px-3 rounded hover:bg-blue-700">
                        <i class="fas fa-gas-pump mr-3"></i>
                        <span class="nav-text text-left flex-grow">Stations</span>
                        <i class="fas fa-chevron-right dropdown-icon text-xs"></i>
                    </button>
                    <div class="dropdown-container">
                        <a href="${pageContext.request.contextPath}/StationServlet" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Liste des stations</a>
                        <a href="${pageContext.request.contextPath}/stations/ajouter.jsp" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Ajouter une station</a>
                    </div>
                </div>

                <!-- Approvisionnement (déroulant) -->
                <div class="mb-1">
                    <button class="dropdown-btn flex items-center w-full py-2 px-3 rounded hover:bg-blue-700">
                        <i class="fas fa-truck mr-3"></i>
                        <span class="nav-text text-left flex-grow">Approvisionnement</span>
                        <i class="fas fa-chevron-right dropdown-icon text-xs"></i>
                    </button>
                    <div class="dropdown-container">
                        <a href="${pageContext.request.contextPath}/ApprovisionnementServlet" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Liste approvisionnement</a>
                        <a href="${pageContext.request.getContextPath()}/approvisionnement/ajouter.jsp" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Nouvel approvisionnement</a>
                    </div>
                </div>


                <div class="mb-1">
                    <button class="dropdown-btn flex items-center w-full py-2 px-3 rounded hover:bg-blue-700">
                        <i class="fas fa-shopping-cart mr-3"></i>
                        <span class="nav-text text-left flex-grow">Ventes</span>
                        <i class="fas fa-chevron-right dropdown-icon text-xs"></i>
                    </button>
                    <div class="dropdown-container">
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Nouvelle vente</a>
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Journal des ventes</a>
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Rapports</a>
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Clients</a>
                    </div>
                </div>
            </div>

            <div class="mb-8">
                <p class="text-blue-200 uppercase text-xs font-bold mb-2 nav-text">Administration</p>


                <div class="mb-1">
                    <button class="dropdown-btn flex items-center w-full py-2 px-3 rounded hover:bg-blue-700">
                        <i class="fas fa-users mr-3"></i>
                        <span class="nav-text text-left flex-grow">Utilisateurs</span>
                        <i class="fas fa-chevron-right dropdown-icon text-xs"></i>
                    </button>
                    <div class="dropdown-container">
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Gestion des utilisateurs</a>
                        <a href="#" class="block py-2 px-3 pl-8 rounded hover:bg-blue-700 text-sm">Rôles & permissions</a>
                    </div>
                </div>
            </div>
        </nav>
    </div>
    <div class="p-4 border-t border-blue-700">
        <div class="flex items-center">
            <div class="nav-text">
                <p class="font-medium">
                    <%=user.getUsername()%>
                </p>
                <p class="text-blue-200 text-sm"><%= user.getRole()%></p>
            </div>
                <a href="${pageContext.request.contextPath}/Logout" class="ml-auto text-blue-200 hover:text-white">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</div>
