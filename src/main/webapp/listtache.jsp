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
            font-size: 16px;
            color: #555;
            background-image: url('${pageContext.request.contextPath}/images/0eb5db109f9335c5c8d500dc626ca1a0.jpg');
            background-size: 100% 100%; /* Stretch to fill both width and height */
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }
        /* Dark overlay for better readability */

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
            color: #d1e3ff; /* Light blue for non-active sidebar icons */
        }
        .active i {
            color: #1e3a8a; /* Match the active text color */
        }
        .menu li a {
            color: inherit; /* Inherit color from parent (white or #1e3a8a when active) */
            text-decoration: none; /* Remove underline from links */
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: 85%;
            max-width: 1200px;
            background: rgba(135, 206, 235, 0.6); /* More transparent to make background image visible */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);

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
            padding: 10px;
            float: right;
            width: 50%;
        /
        }
        .search-container input[type="text"] {
            width: 50%;
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

        .search-container select:focus {
            border-color: #1e3a8a;
        }
        /* Table Container */
        .table-container {
            background: rgba(255, 255, 255, 0.95); /* Semi-transparent white to match blueprint */
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
            background: #4a90e2; /* Medium blue for headers */
            color: #fff; /* White text for better contrast */
            font-size: 1.1rem;
        }
        td {
            font-size: 1rem;
            color: #555;
        }
        tr:nth-child(odd) {
            background: #e6f0fa; /* Lighter blue-gray for odd rows */
        }
        tr:nth-child(even) {
            background: #f9f9f9; /* Off-white for even rows */
        }
        tr:hover {
            background: #b3d4fc; /* Brighter blue on hover */
        }
        /* Action Buttons */
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
            background: #28a745; /* Green for edit button */
            color: white;
        }
        .edit-btn:hover {
            background: #218838; /* Darker green on hover */
        }
        .edit-btn i {
            color: white; /* Ensure edit icon is white */
        }
        .delete-btn {
            background: #c82333; /* Darker red for delete button */
            color: white;
        }
        .delete-btn:hover {
            background: #a71d2a; /* Even darker red on hover */
        }
        .delete-btn i {
            color: white; /* Ensure delete icon is white */
        }
        /* Add Task Button */
        .add-task-btn {
            background: #1e3a8a; /* Dark blue to match sidebar and blueprint theme */
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
            color: white; /* Ensure add icon is white */
        }
        .add-task-btn:hover {
            background: #3b5998; /* Lighter blue on hover for better contrast */
        }

    </style>
</head>
<body>

<div class="sidebar">
    <h2>ConstructionXpert</h2>
    <ul class="menu">
        <li><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
        <li class="active"><a href="<%= request.getContextPath() %>/tache?action=listtache"><i class="fas fa-project-diagram"></i> Tâches</a></li>
        <li><a href="<%= request.getContextPath() %>/projet?action=listprojet"><i class="fas fa-project-diagram"></i> Projets</a></li>
        <li><a href="<%= request.getContextPath() %>/ressource?action=listRessource"><i class="fas fa-box-open"></i> Ressources</a></li>
    </ul>
</div>

<div class="main-content">

    <div class="search-container">
        <input type="text" placeholder="Rechercher une Tâche...">

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
                <td class="actions" >
                    <button class="edit-btn" data-bs-toggle="modal" data-bs-target="#projectModal"
                            onclick="fillModal('<%= tache.getIdTache() %>', '<%= tache.getNomTache() %>', '<%= tache.getDescription() %>', '<%= tache.getNomProjet() %>', '<%= tache.getDateDebut() %>', '<%= tache.getDateFin() %>')">
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
        document.getElementById('idProjet').value = '';
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