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
      background-color: #f5f5f5;
      font-size: 16px;
      color: #333;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
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

    /* Contenu principal */
    .main-content {
      margin-left: 270px;
      padding: 20px;
      width: 85%;
      max-width: 1200px;
      background: white;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      border-radius: 10px;
    }

    /* Header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
    }
    .header h2 {
      color: #333;
      font-size: 1.8rem;
    }
    .header .user-info {
      display: flex;
      align-items: center;
      gap: 15px;
    }
    .header .user-info img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
    }

    .dashboard-cards {
      display: flex;
      justify-content: space-between;
      gap: 20px;
      margin-bottom: 30px;
    }
    .card {
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      flex: 1;
      transition: transform 0.3s ease;
    }
    .card:hover {
      transform: translateY(-10px);
    }
    .card i {
      font-size: 3rem;
      margin-bottom: 15px;
      color: #1e3a8a;
    }
    .card h3 {
      font-size: 1.5rem;
      color: #333;
      margin-bottom: 10px;
    }
    .card p {
      color: #555;
    }

    .task-table-container {
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 14px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    th {
      background: #f8f9fa;
      color: #444;
    }
    tr:nth-child(odd) {
      background: #f9f9f9;
    }
    tr:nth-child(even) {
      background: #fafbfc;
    }
    tr:hover {
      background: #e8f0fe;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <h2>Gestion des Tâches</h2>
  <ul class="menu">
    <li class="active"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
    <li><a href="listtache.jsp"><i class="fas fa-tasks"></i> Tâches</a></li>
    <li><a href="<%= request.getContextPath() %>/projet?action=listprojet">
      <i class="fas fa-project-diagram"></i> Projets
    </a></li>    <li><a href="listressource.jsp"><i class="fas fa-cogs"></i> Ressources</a></li>
  </ul>
</div>

<div class="main-content">
  <div class="header">
    <h2>Tableau de Bord</h2>
    <div class="user-info">
      <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="Avatar de l'utilisateur">
      <span>Jean Dupont</span>
    </div>
  </div>


  <div class="dashboard-cards">

    <div class="card">
      <i class="fas fa-tasks"></i>
      <h3>Tâches en Cours</h3>
      <p>10 tâches en cours sur 20</p>
    </div>

    <div class="card">
      <i class="fas fa-calendar-check"></i>
      <h3>Tâches Terminées</h3>
      <p>8 tâches terminées cette semaine</p>
    </div>

    <div class="card">
      <i class="fas fa-users"></i>
      <h3>Équipe</h3>
      <p>5 membres actifs sur 6</p>
    </div>
  </div>

  <div class="task-table-container">
    <h3>Dernières Tâches</h3>
    <table>
      <thead>
      <tr>
        <th>ID Tâche</th>
        <th>Nom de la Tâche</th>
        <th>Projet</th>
        <th>Date de début</th>
        <th>Date de fin</th>
        <th>Statut</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>#T101</td>
        <td>Évaluation du Site</td>
        <td>Construction du Bureau</td>
        <td>01 Mai 2024</td>
        <td>05 Mai 2024</td>
        <td>En Cours</td>
      </tr>
      <tr>
        <td>#T102</td>
        <td>Installation de l'infrastructure</td>
        <td>Rénovation Appartement</td>
        <td>05 Juin 2024</td>
        <td>10 Juin 2024</td>
        <td>Terminé</td>
      </tr>
      <tr>
        <td>#T103</td>
        <td>Finir la peinture</td>
        <td>Extension du Magasin</td>
        <td>10 Juillet 2024</td>
        <td>15 Juillet 2024</td>
        <td>En Attente</td>
      </tr>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
