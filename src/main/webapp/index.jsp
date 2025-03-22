
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard - Gestion des Tâches</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    /* Styles généraux */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      font-size: 16px;
      color: #333;
      display: flex;
      height: 100vh;
      /* Background image */
      background-image: url('${pageContext.request.contextPath}/images/0eb5db109f9335c5c8d500dc626ca1a0.jpg');
      background-size: 100% 100%; /* Stretch to fill both width and height */
      background-position: center;
      background-repeat: no-repeat;
      position: relative;
    }

    /* Dark overlay for better readability */
    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5); /* Semi-transparent dark overlay */
      z-index: 1;
    }

    /* Barre latérale */
    .sidebar {
      width: 220px;
      height: 100vh;
      background: #1e3a8a;
      color: white;
      padding: 20px;
      position: fixed;
      left: 0;
      top: 0;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
      z-index: 2; /* Ensure sidebar is above the overlay */
    }
    .sidebar h2 {
      margin-bottom: 40px;
      font-size: 1.6rem;
      font-weight: 600;
    }
    .menu {
      list-style: none;
      padding-left: 0;
    }
    .menu li {
      padding: 14px 20px;
      margin: 12px 0;
      background: rgba(255, 255, 255, 0.1);
      cursor: pointer;
      border-radius: 8px;
      transition: background-color 0.3s ease;
    }
    .menu li:hover {
      background: rgba(255, 255, 255, 0.2);
    }
    .active {
      background: white;
      color: #1e3a8a;
      font-weight: bold;
    }
    .menu li i {
      margin-right: 10px;
    }
    .menu li a {
      color: inherit; /* Inherit color from parent (white or #1e3a8a when active) */
      text-decoration: none; /* Remove underline from links */
    }

    /* Contenu principal */
    .main-content {
      margin-left: 270px; /* Account for sidebar width (220px) + padding */
      padding: 20px;
      width: calc(100% - 270px); /* Adjust width to fit beside sidebar */
      z-index: 2; /* Ensure content is above the overlay */
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh; /* Full height to center content vertically */
    }

    /* Centered Message */
    .centered-message {
      background: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      text-align: center;
      max-width: 600px;
      width: 100%;
    }
    .centered-message h3 {
      color: #1e3a8a; /* Dark blue for contrast */
      font-size: 2rem;
      margin-bottom: 10px;
    }
    .centered-message p {
      color: #333;
      font-size: 1.2rem;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <h2>ConstructionXpert</h2>
  <ul class="menu">
    <li class="active"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
    <li><a href="<%= request.getContextPath() %>/tache?action=listtache">
      <i class="fas fa-project-diagram"></i> Taches
    </a></li>
    <li><a href="<%= request.getContextPath() %>/projet?action=listprojet">
      <i class="fas fa-project-diagram"></i> Projets
    </a></li>
    <li><a href="<%= request.getContextPath() %>/ressource?action=listRessource">
      <i class="fas fa-project-diagram"></i> Ressource
    </a></li>
  </ul>
</div>

<div class="main-content">
  <!-- Centered Message -->
  <div class="centered-message">
    <h3>Bienvenue sur ConstructionXpert</h3>
    <p>Gérez vos tâches, projets et ressources efficacement avec ConstructionXpert.</p>
  </div>
</div>

</body>
</html>