package controller;

import com.mysql.cj.x.protobuf.MysqlxDatatypes;
import dao.RessourceDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Ressource;

import java.io.IOException;
import java.util.List;

@WebServlet("/ressource")
public class RessourceServlet extends HttpServlet {
    RessourceDao ressourceDao;

    @Override
    public void init() throws ServletException {
        ressourceDao = new RessourceDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String action = req.getParameter("action");
       switch (action) {
           case "newressource":
               showNewForm(req, resp);
               break;
           case "insertRessource":
               insertRessource(req, resp);
               break;
               case "listRessource":
                   listRessource(req, resp);
                   break;
                   case "deleteRessource":
                       break;
                       default:
       }

    }
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("listressource.jsp");
        dispatcher.forward(request, response);
    }
  private void  insertRessource(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nomRessource = request.getParameter("nomRessource");
        String typeRessource = request.getParameter("typeRessource");
        String fournisseur = request.getParameter("fournisseur");
       int quantite = Integer.parseInt(request.getParameter("quantite"));
       Ressource ressource=new Ressource(nomRessource,typeRessource,fournisseur,quantite);
     ressourceDao.insertRessource(ressource);
      System.out.println("Ressource inserted");
      response.sendRedirect(request.getContextPath() + "/ressource?action=listRessource");

  }
  private void listRessource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      List<Ressource> ressources=ressourceDao.getAllRessource();
      request.setAttribute("ressources", ressources);
      RequestDispatcher dispatcher = request.getRequestDispatcher("listressource.jsp");
      dispatcher.forward(request, response);
  }
}
