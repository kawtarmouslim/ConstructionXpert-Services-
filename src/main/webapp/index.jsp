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
      width: 250px;
      height: 100vh;
      background: #1e3a8a;
      color: white;
      position: fixed;
      top: 0;
      left: 0;
      padding: 20px;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
    }
    .sidebar h2 {
      font-size: 1.8rem;
      margin-bottom: 40px;
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

    /* Cards du Dashboard */
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

    /* Statistiques de tâches */
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

<!-- Barre latérale -->
<div class="sidebar">
  <h2>Gestion des Tâches</h2>
  <ul class="menu">
    <li class="active">Dashboard</li>
    <li>Tâches</li>
    <li>Projets</li>
    <li>Ressources</li>
  </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
  <div class="header">
    <h2>Tableau de Bord</h2>
    <!-- Information de l'utilisateur connecté -->
    <div class="user-info">
      <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="Avatar de l'utilisateur">
      <span>Jean Dupont</span>
    </div>
  </div>

  <!-- Cards du Dashboard -->
  <div class="dashboard-cards">
    <!-- Card 1 -->
    <div class="card">
      <i class="fas fa-tasks"></i>
      <h3>Tâches en Cours</h3>
      <p>10 tâches en cours sur 20</p>
    </div>

    <!-- Card 2 -->
    <div class="card">
      <i class="fas fa-calendar-check"></i>
      <h3>Tâches Terminées</h3>
      <p>8 tâches terminées cette semaine</p>
    </div>

    <!-- Card 3 -->
    <div class="card">
      <i class="fas fa-users"></i>
      <h3>Équipe</h3>
      <p>5 membres actifs sur 6</p>
    </div>
  </div>

  <!-- Statistiques de tâches -->
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
