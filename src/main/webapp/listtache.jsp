<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tâches</title>
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
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            background: #f0f4f8;
            font-size: 16px;
            color: #555;
        }

        /* Barre latérale */
        .sidebar {
            width: 220px; /* Réduit la largeur de la barre latérale */
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
            font-size: 1.6rem; /* Taille réduite */
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
            margin-left: 250px;
            padding: 20px;
            width: 85%;
            max-width: 1200px;
            background: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
        }

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

        /* Barre de recherche et filtre */
        .search-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            background-color: #f1f5fb;
            padding: 10px;
            border-radius: 8px;
        }
        .search-container input[type="text"] {
            width: 60%; /* Réduit la largeur de l'input */
            padding: 8px 15px; /* Réduit le padding */
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 14px; /* Réduit la taille de la police */
            outline: none;
            transition: border-color 0.3s ease;
        }
        .search-container input[type="text"]:focus {
            border-color: #1e3a8a;
        }
        .search-container select {
            width: 35%; /* Réduit la largeur du select */
            padding: 8px;
            border-radius: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            outline: none;
            transition: border-color 0.3s ease;
        }
        .search-container select:focus {
            border-color: #1e3a8a;
        }

        /* Table */
        .table-container {
            background: #f9fafb;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            width: 100%;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #f8f9fa;
            color: #444;
            font-size: 1.1rem;
        }
        td {
            font-size: 1rem;
            color: #555;
        }

        /* Coloration alternée des lignes de la table */
        tr:nth-child(odd) {
            background: #f9f9f9;
        }
        tr:nth-child(even) {
            background: #fafbfc;
        }
        tr:hover {
            background: #e8f0fe;
        }

        .actions button {
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        .edit-btn {
            background: #fbbd08;
            color: white;
        }
        .edit-btn:hover {
            background: #e9a50f;
        }
        .delete-btn {
            background: #dc3545;
            color: white;
        }
        .delete-btn:hover {
            background: #c82333;
        }

        /* Bouton Ajouter une tâche */
        .add-task-btn {
            background: #4caf50;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 25px;
            transition: background-color 0.3s ease;
        }
        .add-task-btn i {
            margin-right: 8px;
        }
        .add-task-btn:hover {
            background: #45a049;
        }
    </style>
</head>
<body>

<!-- Barre latérale -->
<div class="sidebar">
    <h2>Gestion des Tâches</h2>
    <ul class="menu">
        <li class="active"><i class="fas fa-home"></i> Dashboard</li>
        <li><i class="fas fa-tasks"></i> Tâches</li>
        <li><i class="fas fa-project-diagram"></i> Projets</li>
        <li><i class="fas fa-cogs"></i> Ressources</li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="header">
        <h2>Tâches de Projet</h2>
    </div>

    <!-- Barre de recherche et de filtre -->
    <div class="search-container">
        <input type="text" placeholder="Rechercher une tâche...">
        <select>
            <option value="all">Tous les Projets</option>
            <option value="construction">Construction du Bureau</option>
            <option value="renovation">Rénovation Appartement</option>
            <option value="expansion">Extension du Magasin</option>
        </select>
    </div>

    <!-- Bouton pour ajouter une tâche avec icône -->
    <button class="add-task-btn">
        <i class="fas fa-plus"></i> Ajouter une Tâche
    </button>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID Tâche</th>
                <th>Nom de la Tâche</th>
                <th>Projet</th>
                <th>Date de début</th>
                <th>Date de fin</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="task-table">
            <tr>
                <td>#T101</td>
                <td>Évaluation du Site</td>
                <td>Construction du Bureau</td>
                <td>01 Mai 2024</td>
                <td>05 Mai 2024</td>
                <td class="actions">
                    <button class="edit-btn"><i class="fas fa-edit"></i></button>
                    <button class="delete-btn"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
            <tr style="background: #e8f0fe;">
                <td>#T102</td>
                <td><strong style="color: #0d6efd;">Installation de l'infrastructure</strong></td>
                <td>Rénovation Appartement</td>
                <td>05 Juin 2024</td>
                <td>10 Juin 2024</td>
                <td class="actions">
                    <button class="edit-btn"><i class="fas fa-edit"></i></button>
                    <button class="delete-btn"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>

