/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.servlet;

import giangvt.tblproduct.TblProductDAO;
import giangvt.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author MY HP
 */
public class SearchCakeServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(SearchCakeServlet.class);
    private final String ERROR_PAGE = "error.jsp";
    private final String SEARCH_PAGE = "search.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = ERROR_PAGE;

        String name = request.getParameter("txtName");
        String max = request.getParameter("txtHigh");
        String min = request.getParameter("txtLow");
        String cateId = request.getParameter("cbCateId");
        int role = -1;
        List<TblProductDTO> list = null;

        HttpSession session = request.getSession(false);
        if (session != null) {
            if (session.getAttribute("ROLE") != null) {
                role = (int) session.getAttribute("ROLE");
            }
        }
        try {
            if (name == null || max == null || min == null || cateId == null) {
                TblProductDAO dao = new TblProductDAO();
                double maxPrice = dao.getMaxPrice();
                list = dao.searchCake(1, "", 0, maxPrice, -1, role);
                request.setAttribute("LIST", list);
                url = SEARCH_PAGE;
                // khong con field nao null het nen cham thoai mai
            } else if (!max.matches("\\d+") || !min.matches("\\d+")
                    || !cateId.matches("[+-]?[0-9][0-9]*")) {
                url = ERROR_PAGE;
            } else {
                TblProductDAO dao = new TblProductDAO();
                list = dao.searchCake(1, name, Double.parseDouble(min), Double.parseDouble(max)
                        , Integer.parseInt(cateId), role);
                request.setAttribute("LIST", list);
                url = SEARCH_PAGE;
            }
            request.setAttribute("PAGE", 1);
        } catch (SQLException ex) {
            LOGGER.info("SearchCakeServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("SearchCakeServlet _ Naming: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
