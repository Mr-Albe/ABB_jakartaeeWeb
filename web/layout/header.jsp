<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestion des Stations d'Essence</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .sidebar {
                transition: all 0.3s;
            }
            .sidebar.collapsed {
                width: 70px;
            }
            .sidebar.collapsed .nav-text {
                display: none;
            }
            .sidebar.collapsed .logo-text {
                display: none;
            }
            .sidebar.collapsed .nav-item {
                justify-content: center;
            }
            .sidebar.collapsed .dropdown-btn {
                justify-content: center;
            }
            .content {
                transition: all 0.3s;
            }
            .sidebar.collapsed + .content {
                margin-left: 70px;
            }
            .progress-bar {
                height: 10px;
                border-radius: 5px;
                background-color: #e0e0e0;
            }
            .progress-fill {
                height: 100%;
                border-radius: 5px;
                transition: width 0.3s ease;
            }
            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            .dropdown-container {
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.3s ease-out;
            }
            .dropdown-container.open {
                max-height: 500px;
            }
            .dropdown-btn .dropdown-icon {
                transition: transform 0.3s;
            }
            .dropdown-btn.open .dropdown-icon {
                transform: rotate(90deg);
            }
            @media (max-width: 768px) {
                .sidebar {
                    position: absolute;
                    z-index: 100;
                    transform: translateX(-100%);
                }
                .sidebar.show {
                    transform: translateX(0);
                }
                .content {
                    margin-left: 0 !important;
                }
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="flex h-screen overflow-hidden"> 