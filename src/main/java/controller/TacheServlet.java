package controller;

import dao.ProjetDao;
import dao.RessourceDao;
import dao.TacheDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Projet;
import model.Ressource;
import model.Tache;

import java.io.IOException;
import java.util.ArrayList;
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
            List<Projet> projets = projetDao.getAllProjets();
            req.setAttribute("projets", projets);

            // Add resources to the request for the modal
            RessourceDao ressourceDao = new RessourceDao();
            List<Ressource> ressources = ressourceDao.getAllRessource();
            req.setAttribute("ressources", ressources);

            String action = req.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "newtache":
                        showNewTacheForm(req, resp);
                        break;
                    case "cretetache":
                        insertTache(req, resp);
                        break;
                    case "listtache":
                        listTache(req, resp);
                        break;
                    case "assignRessource":
                        assignRessourceToTache(req, resp);
                        break;
                    // Add other cases as needed
                    default:
                        resp.sendRedirect(req.getContextPath() + "/tache?action=listtache");
                }
            }
        }

        private void assignRessourceToTache(HttpServletRequest req, HttpServletResponse resp) throws IOException {
            int idTache = Integer.parseInt(req.getParameter("idTache"));
            int idRessource = Integer.parseInt(req.getParameter("idRessource"));
            int quantite = Integer.parseInt(req.getParameter("quantite"));

            RessourceDao ressourceDao = new RessourceDao();
            ressourceDao.assignRessourceToTache(idTache, idRessource, quantite);

            resp.sendRedirect(req.getContextPath() + "/tache?action=listtache");
        }
    private void showNewTacheForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("addTache.jsp");
        dispatcher.forward(req, resp);
    }

    public void insertTache(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nomTache");
        String description = req.getParameter("description");
        int idProjet = Integer.parseInt(req.getParameter("idProjet"));
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");

        Tache tache = new Tache(nom, description, idProjet, dateDebut, dateFin);
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