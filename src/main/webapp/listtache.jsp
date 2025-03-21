<%@ page import="model.Projet" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Tache" %>
<%@ page import="model.Ressource" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tâches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .actions button {
            border: none;
            padding: 8px 15px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
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
        .resource-btn {
            background: #17a2b8;
            color: white;
        }
        .resource-btn:hover {
            background: #138496;
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
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Gestion des Tâches</h2>
    <ul class="menu">
        <li><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="active"><a href="<%= request.getContextPath() %>/tache?action=listtache"><i class="fas fa-project-diagram"></i> Tâches</a></li>
        <li><a href="<%= request.getContextPath() %>/projet?action=listprojet"><i class="fas fa-project-diagram"></i> Projets</a></li>
        <li><a href="<%= request.getContextPath() %>/ressource?action=listRessource"><i class="fas fa-box-open"></i> Ressources</a></li>
    </ul>
</div>

<div class="main-content">
    <div class="header">
        <h2>Les Tâches</h2>
    </div>
    <div class="search-container">
        <input type="text" placeholder="Rechercher une Tâche...">
        <select>
            <option value="all">Tous les Projets</option>
            <option value="construction">Construction</option>
            <option value="renovation">Rénovation</option>
            <option value="expansion">Expansion</option>
        </select>
    </div>
    <button class="add-task-btn btn btn-primary" data-bs-toggle="modal" data-bs-target="#projectModal" onclick="resetModal()">
        <i class="fas fa-plus"></i> Ajouter une Tâche
    </button>

    <!-- Modal for adding/updating a task -->
    <div class="modal fade" id="projectModal" tabindex="-1" aria-labelledby="projectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-4 shadow-lg rounded-3" style="background-color: #f8f9fa;">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold text-primary" id="projectModalLabel">Nouvelle Tâche</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="projectForm" action="<%= request.getContextPath() %>/tache?action=cretetache" method="POST">
                        <input type="hidden" id="idTache" name="idTache">
                        <div class="mb-3">
                            <label for="projectName" class="form-label fw-bold">Nom Tâche</label>
                            <input type="text" class="form-control rounded-3" id="projectName" name="nomTache" placeholder="Entrez le nom du tâche" required>
                        </div>
                        <div class="mb-3">
                            <label for="projectDescription" class="form-label fw-bold">Description</label>
                            <textarea class="form-control rounded-3" id="projectDescription" name="description" rows="3" placeholder="Entrez la description du tâche"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="idProjet" class="form-label fw-bold">Projet</label>
                            <select class="form-control rounded-3" id="idProjet" name="idProjet" required>
                                <option value="">Sélectionnez un projet</option>
                                <%
                                    List<Projet> projets = (List<Projet>) request.getAttribute("projets");
                                    if (projets != null) {
                                        for (Projet p : projets) {
                                %>
                                <option value="<%= p.getIdProjet() %>"><%= p.getNomProjet() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="projectDate" class="form-label fw-bold">Date de début</label>
                                <input type="date" class="form-control rounded-3" id="projectDate" name="dateDebut" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="datefin" class="form-label fw-bold">Date de fin</label>
                                <input type="date" class="form-control rounded-3" id="datefin" name="dateFin" required>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" form="projectForm" class="btn btn-primary rounded-3" id="submitButton">Créer</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for assigning resources to a task -->
    <div class="modal fade" id="resourceModal" tabindex="-1" aria-labelledby="resourceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-4 shadow-lg rounded-3" style="background-color: #f8f9fa;">
                <div class="modal-header border-0">
                    <h5 class="modal-title fw-bold text-primary" id="resourceModalLabel">Assigner une Ressource</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="resourceForm" action="<%= request.getContextPath() %>/tache?action=assignRessource" method="POST">
                        <input type="hidden" id="idTacheResource" name="idTache">
                        <div class="mb-3">
                            <label for="idRessource" class="form-label fw-bold">Ressource</label>
                            <select class="form-control rounded-3" id="idRessource" name="idRessource" required>
                                <option value="">Sélectionnez une ressource</option>
                                <%
                                    List<Ressource> ressources = (List<Ressource>) request.getAttribute("ressources");
                                    if (ressources != null) {
                                        for (Ressource r : ressources) {
                                %>
                                <option value="<%= r.getIdRessource() %>"><%= r.getNomRessource() %> (Disponible: <%= r.getQuantite() %>)</option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="quantite" class="form-label fw-bold">Quantité</label>
                            <input type="number" class="form-control rounded-3" id="quantite" name="quantite" min="1" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary rounded-3" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" form="resourceForm" class="btn btn-primary rounded-3">Assigner</button>
                </div>
            </div>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID Tâche</th>
                <th>Nom de la Tâche</th>
                <th>Description</th>
                <th>Nom Projet</th>
                <th>Date de début</th>
                <th>Date de fin</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="task-table">
            <%
                List<Tache> taches = (List<Tache>) request.getAttribute("taches");
                if (taches != null) {
                    for (Tache tache : taches) {
            %>
            <tr>
                <td><%= tache.getIdTache() %></td>
                <td><%= tache.getNomTache() %></td>
                <td><%= tache.getDescription() %></td>
                <td><%= tache.getNomProjet() %></td>
                <td><%= tache.getDateDebut() %></td>
                <td><%= tache.getDateFin() %></td>
                <td class="actions" style="width: 200px";>
                    <button class="edit-btn" data-bs-toggle="modal" data-bs-target="#projectModal"
                            onclick="fillModal('<%= tache.getIdTache() %>', '<%= tache.getNomTache() %>', '<%= tache.getDescription() %>', '<%= tache.getIdProjet() %>', '<%= tache.getDateDebut() %>', '<%= tache.getDateFin() %>')">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="delete-btn">
                        <a href="<%= request.getContextPath() %>/tache?action=deleteTache&id=<%= tache.getIdTache() %>">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </button>
                    <button class="resource-btn" data-bs-toggle="modal" data-bs-target="#resourceModal" onclick="setTacheId('<%= tache.getIdTache() %>')">
                        <i class="fas fa-box-open"></i>
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
    function fillModal(idTache, nomTache, description, nomProjet, dateDebut, dateFin) {
        document.getElementById('projectModalLabel').innerText = 'Modifier une Tâche';
        document.getElementById('idTache').value = idTache;
        document.getElementById('projectName').value = nomTache;
        document.getElementById('projectDescription').value = description;
        document.getElementById('idProjet').value = nomProjet;
        document.getElementById('projectDate').value = dateDebut;
        document.getElementById('datefin').value = dateFin;
        document.getElementById('projectForm').action = '<%= request.getContextPath() %>/tache?action=updateTache';
        document.getElementById('submitButton').innerText = 'Mettre à jour';
    }

    function resetModal() {
        document.getElementById('projectModalLabel').innerText = 'Nouvelle Tâche';
        document.getElementById('idTache').value = '';
        document.getElementById('projectName').value = '';
        document.getElementById('projectDescription').value = '';
        document.getElementById('nomProjet').value = '';
        document.getElementById('projectDate').value = '';
        document.getElementById('datefin').value = '';
        document.getElementById('projectForm').action = '<%= request.getContextPath() %>/tache?action=cretetache';
        document.getElementById('submitButton').innerText = 'Créer';
    }

    function setTacheId(idTache) {
        document.getElementById('idTacheResource').value = idTache;
    }
</script>
</body>
</html>