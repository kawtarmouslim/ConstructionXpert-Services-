package controller;

import dao.ProjetDao;
import dao.TacheDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Projet;
import model.Tache;

import java.io.IOException;
import java.util.List;

@WebServlet("/tache")
public class TacheServlet extends HttpServlet {
    TacheDao tacheDao;
    ProjetDao projetDao = new ProjetDao();
    @Override
    public void init() throws ServletException {
        tacheDao = new TacheDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Projet> projets = projetDao.getAllProjets();  // Récupère les projets depuis la base
        req.setAttribute("projets", projets);  // Envoie à la JSP

        String action = req.getParameter("action");
        switch (action) {
            case "newtache":
                break;
            case "cretetache":
                insertTache(req, resp);
                break;
            case "listtache":
                listTache(req, resp);
                break;
            case "updatetache":
                break;
            case "deletetache":
                break;
            default:
        }
    }

  public void insertTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String nom = req.getParameter("nomTache");
            String description = req.getParameter("description");
            int idProjet = Integer.parseInt(req.getParameter("idProjet"));
            String dateDebut = req.getParameter("dateDebut");
            String dateFin = req.getParameter("dateFin");
      Tache tache=new Tache(nom,description,idProjet,dateDebut,dateFin);
      tacheDao.insertTache(tache);
      resp.sendRedirect(req.getContextPath() + "/tache?action=listtache");
  }
  public void listTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      List<Tache>taches=tacheDao.getAllTaches();
      req.setAttribute("taches", taches);
      RequestDispatcher dispatcher = req.getRequestDispatcher("listtache.jsp");
      dispatcher.forward(req, resp);

  }
}