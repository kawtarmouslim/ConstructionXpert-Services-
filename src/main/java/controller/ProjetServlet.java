package controller;

import dao.ProjetDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Projet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/projet")
public class ProjetServlet extends HttpServlet {
    ProjetDao projetDao ;
    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "newprojet":
                showNewForm(req, resp);
                break;
            case "createprojet":
                ajoutProjet(req, resp);
                break;
                case "listprojet":
                    listProjet(req, resp);
                    break;
                    case "updateprojet":
                        updaterProjet(req, resp);
                        break;
                        case "deleteprojet":
                            supprimerProjet(req, resp);
                            break;
                    default:
                        break;
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("listprojet.jsp");
        dispatcher.forward(request, response);
    }
     public void ajoutProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nomProjet = req.getParameter("nomProjet");
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("datefin");
        float budget = Float.parseFloat(req.getParameter("budget"));
        Projet projet = new Projet(nomProjet, description, dateDebut, dateFin, budget);
       projetDao.insertProjet(projet);

         resp.sendRedirect(req.getContextPath() + "/projet?action=listprojet");
     }
     public void listProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         List<Projet> projets=projetDao.getAllProjets();
         req.setAttribute("projets",projets);
         System.out.println("hello");
         RequestDispatcher dispatcher = req.getRequestDispatcher("listprojet.jsp");
         dispatcher.forward(req, resp);

     }
     public void supprimerProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                  int id = Integer.parseInt(req.getParameter("id"));
                  projetDao.deleteProjet(id);
                  resp.sendRedirect(req.getContextPath() + "/projet?action=listprojet");

     }
     public void updaterProjet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nomProjet = req.getParameter("nomProjet");
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        float budget = Float.parseFloat(req.getParameter("budget"));
         Projet projet=new Projet(nomProjet, description, dateDebut, dateFin, budget);
         projetDao.updateProjet(projet);
         System.out.println("update");
     }

}
