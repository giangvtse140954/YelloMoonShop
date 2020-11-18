/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.servlet;

import giangvt.tblcate.TblCateDAO;
import giangvt.tblcate.TblCateDTO;
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
import org.apache.log4j.Logger;

/**
 *
 * @author MY HP
 */
public class ShowDetailServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(ShowDetailServlet.class);
    private final String ERROR_PAGE = "error.jsp";
    private final String DETAIL_PAGE = "detail.jsp";

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

        try {
            String id = request.getParameter("txtProId");
            if (id != null) {
                if (id.matches("\\d+")) {
                    TblProductDAO dao = new TblProductDAO();
                    TblProductDTO dto = dao.getProductById(Integer.parseInt(id));
                    TblCateDAO cateDao = new TblCateDAO();
                    if (dto != null) {
                        String cate = cateDao.getName(dto.getCateId());
                        List<TblCateDTO> cateList = cateDao.getCateList();
                        request.setAttribute("CATE", cate);
                        request.setAttribute("DTO", dto);
                        request.setAttribute("CATE_LIST", cateList);
                        url = DETAIL_PAGE;
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.info("ShowDetailServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("ShowDetailServlet _ Naming: " + ex.getMessage());
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
