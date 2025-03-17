
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire Popup</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #1e3a8a, #2563eb, #93c5fd);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .main-container {
            text-align: center;
        }

        .open-form-btn {
            padding: 15px 30px;
            background: #1e3a8a;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(30, 58, 138, 0.4);
            transition: all 0.3s;
        }

        .open-form-btn:hover {
            background: #2563eb;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(30, 58, 138, 0.6);
        }

        .open-form-btn:active {
            transform: translateY(1px);
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .form-container {
            width: 100%;
            max-width: 500px;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(30, 58, 138, 0.3);
            position: relative;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .modal-overlay.active .form-container {
            transform: translateY(0);
        }

        .close-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #1e3a8a;
            transition: all 0.2s;
        }

        .close-btn:hover {
            color: #2563eb;
            transform: scale(1.1);
        }

        h1 {
            text-align: center;
            color: #1e3a8a;
            margin-bottom: 30px;
            font-weight: 700;
            position: relative;
        }

        h1::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: -10px;
            transform: translateX(-50%);
            width: 70px;
            height: 4px;
            background: #1e3a8a;
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e3a8a;
            text-align: left;
        }

        input, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid rgba(30, 58, 138, 0.2);
            background: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            box-shadow: 0 2px 10px rgba(30, 58, 138, 0.1);
            transition: all 0.3s;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: #1e3a8a;
            box-shadow: 0 5px 15px rgba(30, 58, 138, 0.2);
            background: white;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .price-input {
            position: relative;
        }

        .price-input span {
            position: absolute;
            left: 15px;
            top: 12px;
            color: #1e3a8a;
        }

        .price-input input {
            padding-left: 30px;
        }

        .date-inputs {
            display: flex;
            gap: 15px;
        }

        .date-inputs .form-group {
            flex: 1;
        }

        button[type="submit"] {
            width: 100%;
            padding: 15px;
            background: #1e3a8a;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(30, 58, 138, 0.4);
            transition: all 0.3s;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background: #2563eb;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(30, 58, 138, 0.6);
        }

        button[type="submit"]:active {
            transform: translateY(1px);
        }

        @media (max-width: 500px) {
            .form-container {
                padding: 20px;
                margin: 0 15px;
            }

            .date-inputs {
                flex-direction: column;
                gap: 10px;
            }

            button {
                padding: 12px;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <button class="open-form-btn" id="openFormBtn">Ajouter un nouveau projet</button>
</div>

<div class="modal-overlay" id="modalOverlay">
    <div class="form-container">
        <button class="close-btn" id="closeFormBtn">&times;</button>
        <h1>Ajouter un Projet</h1>
        <form id="projectForm">
            <div class="form-group">
                <label for="title">Titre du projet</label>
                <input type="text" id="title" name="title" placeholder="Entrez le titre du projet" required>
            </div>

            <div class="form-group">
                <label for="name">Nom du projet</label>
                <input type="text" id="name" name="name" placeholder="Entrez le nom du projet" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" placeholder="Entrez la description du projet" required></textarea>
            </div>

            <div class="date-inputs">
                <div class="form-group">
                    <label for="startDate">Date de début</label>
                    <input type="date" id="startDate" name="startDate" required>
                </div>

                <div class="form-group">
                    <label for="endDate">Date de fin</label>
                    <input type="date" id="endDate" name="endDate" required>
                </div>
            </div>

            <div class="form-group">
                <label for="price">Budget du projet</label>
                <div class="price-input">
                    <span>€</span>
                    <input type="number" id="price" name="price" placeholder="Entrez le budget du projet" min="0" step="0.01" required>
                </div>
            </div>

            <button type="submit">Ajouter le projet</button>
        </form>
    </div>
</div>

<script>
    // Éléments du DOM
    const openFormBtn = document.getElementById('openFormBtn');
    const closeFormBtn = document.getElementById('closeFormBtn');
    const modalOverlay = document.getElementById('modalOverlay');
    const projectForm = document.getElementById('projectForm');

    // Ouvrir le formulaire
    openFormBtn.addEventListener('click', function() {
        modalOverlay.classList.add('active');
    });

    // Fermer le formulaire
    closeFormBtn.addEventListener('click', function() {
        modalOverlay.classList.remove('active');
    });

    // Fermer le formulaire en cliquant sur l'arrière-plan
    modalOverlay.addEventListener('click', function(e) {
        if (e.target === modalOverlay) {
            modalOverlay.classList.remove('active');
        }
    });

    // Traitement du formulaire
    projectForm.addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Projet ajouté avec succès!');
        this.reset();
        modalOverlay.classList.remove('active');
    });
</script>
</body>
</html>
