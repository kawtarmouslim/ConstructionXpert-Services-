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
    <title>Gestion des Ressources</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
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
        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        button {
            background-color: #f0f0f0;
            border: none;
            padding: 8px;
            cursor: pointer;
            font-size: 16px;
        }
        button i {
            margin-right: 5px;
        }
        button:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h2>Gestion des Ressources</h2>
    <ul class="menu">
        <li><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
        <li><a href="<%= request.getContextPath() %>/tache?action=listtache"><i class="fas fa-project-diagram"></i> Tâches</a></li>
        <li><a href="<%= request.getContextPath() %>/projet?action=listprojet"><i class="fas fa-project-diagram"></i> Projets</a></li>
        <li class="active"><a href="<%= request.getContextPath() %>/ressource?action=listRessource"><i class="fas fa-box-open"></i> Ressources</a></li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
        <h2>Les Ressources</h2>
    </div>
    <div class="search-container">
        <input type="text" placeholder="Rechercher une Ressource...">
        <select>
            <option value="all">Tous les Ressources</option>
            <option value="construction">Construction</option>
            <option value="renovation">Rénovation</option>
            <option value="expansion">Expansion</option>
        </select>
    </div>

    <button class="add-task-btn btn btn-primary" data-bs-toggle="modal" data-bs-target="#projectModal" onclick="resetModal()">
        <i class="fas fa-plus"></i> Ajouter Ressource
    </button>

    <!-- Modal for adding/updating resources -->
    <div class="modal fade" id="projectModal" tabindex="-1" aria-labelledby="projectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-4 shadow-lg rounded-3" style="background-color: #f8f9fa;">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold text-primary" id="projectModalLabel">Nouveau Ressource</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="projectForm" action="<%= request.getContextPath() %>/ressource?action=insertRessource" method="post">
                        <input type="hidden" id="idRessource" name="idRessource">
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
                            <label for="quantite" class="form-label fw-bold">Quantité</label>
                            <input type="number" class="form-control rounded-3" id="quantite" name="quantite" placeholder="Entrez quantité" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" form="projectForm" class="btn btn-primary rounded-3">Enregistrer</button>
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
                <th>Quantité</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="task-table">
            <%
                if (ressources != null) {
                    for (Ressource ressource : ressources) {
            %>
            <tr>
                <td><%= ressource.getIdRessource() %></td>
                <td><%= ressource.getNomRessource() %></td>
                <td><%= ressource.getType() %></td>
                <td><%= ressource.getFournisseur() %></td>
                <td><%= ressource.getQuantite() %></td>
                <td class="actions">
                    <button class="edit-btn" data-bs-toggle="modal" data-bs-target="#projectModal"
                            onclick="fillModal('<%= ressource.getIdRessource() %>', '<%= ressource.getNomRessource() %>', '<%= ressource.getType() %>', '<%= ressource.getFournisseur() %>', '<%= ressource.getQuantite() %>')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="delete-btn">
                        <a href="<%= request.getContextPath() %>/ressource?action=deleteRessource&id=<%= ressource.getIdRessource() %>">
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
<script>
    function fillModal(id, nomRessource, typeRessource, fournisseur, quantite) {
        document.getElementById('projectModalLabel').innerText = 'Modifier une Ressource';
        document.getElementById('idRessource').value = id;
        document.getElementById('nomRessource').value = nomRessource;
        document.getElementById('typeRessource').value = typeRessource;
        document.getElementById('fournisseur').value = fournisseur;
        document.getElementById('quantite').value = quantite;
        document.getElementById('projectForm').action = '<%= request.getContextPath() %>/ressource?action=updateRessource';
    }

    function resetModal() {
        document.getElementById('projectModalLabel').innerText = 'Nouveau Ressource';
        document.getElementById('idRessource').value = '';
        document.getElementById('nomRessource').value = '';
        document.getElementById('typeRessource').value = '';
        document.getElementById('fournisseur').value = '';
        document.getElementById('quantite').value = '';
        document.getElementById('projectForm').action = '<%= request.getContextPath() %>/ressource?action=insertRessource';
    }
</script>
</body>
</html>