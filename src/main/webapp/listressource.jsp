<%@ page import="model.Projet" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ressource" %>
<%
    List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            width: 60%;
            padding: 8px 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease;
        }
        .search-container input[type="text"]:focus {
            border-color: #1e3a8a;
        }
        .search-container select {
            width: 35%;
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

<div class="sidebar">
    <h2>Gestion des Ressource</h2>
    <ul class="menu">
        <li class="active"><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
        <li><a href="<%= request.getContextPath() %>/tache?action=listtache">
            <i class="fas fa-project-diagram"></i> Taches
        </a></li>
        <li><a href="<%= request.getContextPath() %>/projet?action=listprojet">
            <i class="fas fa-project-diagram"></i> Projets
        </a></li>
        <li><a href="<%= request.getContextPath() %>/ressource?action=listRessource">
            <i class="fas fa-project-diagram"></i> Projets
        </a></li>
    </ul>
</div>

<!-- Contenu principal -->
<div class="main-content">
    <div class="header">
        <h2>Les Ressource</h2>
    </div>
    <div class="search-container">
        <input type="text" placeholder="Rechercher une Ressource...">
        <select>
            <option value="all">Tous les Ressource</option>
            <option value="construction"></option>
            <option value="renovation"></option>
            <option value="expansion"></option>
        </select>
    </div>


    <!-- Bouton pour déclencher le modal -->
    <button class="add-task-btn btn btn-primary" data-bs-toggle="modal" data-bs-target="#projectModal">
        <i class="fas fa-plus"></i> Ajouter Ressource
    </button>

    <!-- Modal -->
    <div class="modal fade" id="projectModal" tabindex="-1" aria-labelledby="projectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-4 shadow-lg rounded-3" style="background-color: #f8f9fa;">
                <!-- En-tête du modal -->
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold text-primary" id="projectModalLabel">Nouveau Ressource</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <form id="projectForm" action="<%= request.getContextPath() %>/ressource?action=insertRessource" method="post">

                        <div class="mb-3">
                            <label for="nomRessource" class="form-label fw-bold">Nom Ressource</label>
                            <input type="text" class="form-control rounded-3" id="nomRessource" name="nomRessource" placeholder="Entrez le nom ressource" required>
                        </div>

                        <div class="mb-3">
                            <label for="typeRessource" class="form-label fw-bold">Type</label>
                            <input type="text" class="form-control rounded-3" id="typeRessource" name="typeRessource" placeholder="Entrez Type" required>
                        </div>

                        <div class="mb-3">
                            <label for="fournisseur" class="form-label fw-bold">Fournisseur</label>
                            <input type="text" class="form-control rounded-3" id="fournisseur" name="fournisseur" placeholder="Entrez Fournisseur" required>
                        </div>
                        <div class="mb-3">
                            <label for="quantite" class="form-label fw-bold">Qantite</label>
                            <div class="input-group">
                                <span class="input-group-text">€</span>
                                <input type="text" class="form-control rounded-3" id="quantite" name="quantite" placeholder="Entrez quantite" required>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Pied du modal -->
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" form="projectForm" class="btn btn-primary rounded-3">Créer le Ressource</button>
                </div>
            </div>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID Ressource</th>
                <th>Nom de la Ressource</th>
                <th>Type</th>
                <th>Fournisseur</th>
                <th>Quantite</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="task-table">
            <%
                if (ressources != null) {
                    for (Ressource ressource1 : ressources) {
            %>
            <tr>
                <td><%= ressource1.getIdRessource() %></td>
                <td><%= ressource1.getNomRessource() %></td>
                <td><%= ressource1.getType() %></td>
                <td><%= ressource1.getFournisseur() %></td>
                <td><%= ressource1.getQuantite() %></td>
                <td class="actions">
                    <button class="edit-btn">
                        <a href="<%= request.getContextPath() %>/projet?action=updateprojet&id=<%= ressource1.getIdRessource() %>">
                            <i class="fas fa-edit"></i>
                        </a>
                    </button>
                    <button class="delete-btn">
                        <a href="<%= request.getContextPath() %>/?action=deleteprojet&id=<%= ressource1.getIdRessource() %>">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
