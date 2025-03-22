<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page de Connexion - SolarBuild</title>
    <!-- Inclure Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-image: url('${pageContext.request.contextPath}/images/0eb5db109f9335c5c8d500dc626ca1a0.jpg');
            background-size: 100% 100%; /* Stretch to fill both width and height */
            background-position: center;
            background-repeat: no-repeat;
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Dark overlay for contrast */
            z-index: 1;
        }

        .nav-links {
            position: absolute;
            top: 20px;
            right: 20px;
            z-index: 2;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #87CEEB; /* Light sky blue to match blueprint tones */
        }

        .login-container {
            background: rgba(70, 130, 180, 0.8); /* Semi-transparent steel blue to match blueprint */
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
            z-index: 2;
            position: relative;
            overflow: hidden;
        }

        .login-container h2 {
            color: #FFFFFF; /* White for contrast */
            margin-bottom: 25px;
            font-size: 24px;
            font-weight: 700;
        }

        .input-group {
            position: relative;
            margin-bottom: 15px;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #FFFFFF; /* White for icons */
            font-size: 16px;
        }

        .input-group input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border: 1px solid #FFFFFF; /* White borders for inputs */
            border-radius: 25px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .input-group input:focus {
            border-color: #87CEEB; /* Light sky blue for focus */
            box-shadow: 0 0 8px rgba(135, 206, 235, 0.3);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .checkbox-group input[type="checkbox"] {
            margin-right: 8px;
            accent-color: #87CEEB; /* Light sky blue for checkbox */
        }

        .checkbox-group label {
            color: #FFFFFF; /* White for label */
            font-size: 12px;
        }

        .login-container button {
            background: linear-gradient(90deg, #1E90FF, #4169E1); /* Gradient from dodger blue to royal blue */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 25px;
            width: 100%;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.1s ease, background 0.3s ease;
        }

        .login-container button:hover {
            background: linear-gradient(90deg, #4169E1, #1E90FF); /* Reverse gradient for hover */
            transform: scale(1.02);
        }

        .login-container button:active {
            transform: scale(0.98);
        }

        @media (max-width: 960px) {
            body {
                width: 100%;
                height: 100vh;
            }

            .login-container {
                width: 90%;
                padding: 25px;
            }

            .nav-links {
                top: 10px;
                right: 10px;
            }

            .nav-links a {
                margin: 0 10px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<div class="nav-links">
    <a href="index.jsp">Accueil</a>
    <a href="#">Services</a>
    <a href="#">À propos</a>
    <a href="#">Contact</a>
</div>
<div class="login-container">
    <h2>SolarBuild Platform</h2>
    <form action="seConnecter" method="post">
        <div class="input-group">
            <i class="fas fa-envelope"></i>
            <input type="email" name="username" placeholder="Email" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Mot de passe" required>
        </div>
        <div class="checkbox-group">
            <input type="checkbox" name="remember" id="remember">
            <label for="remember">Se souvenir de moi</label>
        </div>
        <button type="submit">Connexion</button>
    </form>
</div>
</body>
</html>