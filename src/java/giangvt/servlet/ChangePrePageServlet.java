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
public class ChangePrePageServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(ChangePrePageServlet.class);
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
        String page = request.getParameter("page");
        List<TblProductDTO> list = null;
        int role = -1;

        try {
            HttpSession session = request.getSession(false);
            if (session.getAttribute("ROLE") != null) {
                role = (int) session.getAttribute("ROLE");
            }
            if (page != null) {
                if (page.matches("\\d+")) {
                    int pageNum = Integer.parseInt(page);

                    if (name != null && max != null && min != null && cateId != null) {
                        if (max.equals("") && min.equals("") && name.equals("")
                                && cateId.equals("")) {
                            TblProductDAO dao = new TblProductDAO();
                            double maxPrice = dao.getMaxPrice();
                            if (pageNum == 1) {
                                list = dao.searchCake(pageNum, "", 0, maxPrice, -1, role);
                                request.setAttribute("PAGE", pageNum);
                            } else {
                                list = dao.searchCake(pageNum - 1, "", 0, maxPrice, -1, role);
                                request.setAttribute("PAGE", pageNum - 1);
                            }
                            url = SEARCH_PAGE;
                        } else if (max.matches("\\d+") && min.matches("\\d+")
                                && cateId.matches("[+-]?[0-9][0-9]*")) {
                            TblProductDAO dao = new TblProductDAO();
                            if (pageNum == 1) {
                                list = dao.searchCake(pageNum, "", Double.parseDouble(min),
                                        Double.parseDouble(max), Integer.parseInt(cateId), role);
                                request.setAttribute("PAGE", pageNum);
                            } else {
                                list = dao.searchCake(pageNum - 1, "", Double.parseDouble(min),
                                        Double.parseDouble(max), Integer.parseInt(cateId), role);
                                request.setAttribute("PAGE", pageNum - 1);
                            }
                            url = SEARCH_PAGE;
                        }
                    }
                }
            }

            request.setAttribute("LIST", list);
        } catch (SQLException ex) {
            LOGGER.info("ChangePrePageServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("ChangePrePageServlet _ Naming: " + ex.getMessage());
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
