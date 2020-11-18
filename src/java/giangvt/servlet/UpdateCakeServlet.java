/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.servlet;

import giangvt.tbllog.TblLogDAO;
import giangvt.tbllog.TblLogDTO;
import giangvt.tblproduct.TblProductDAO;
import giangvt.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;
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
public class UpdateCakeServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(UpdateCakeServlet.class);
    private final String ERROR_PAGE = "error.jsp";

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
        String id = request.getParameter("txtProId");
        String name = request.getParameter("txtName");
        String price = request.getParameter("txtPrice");
        String quantity = request.getParameter("txtQuantity");
        String cateId = request.getParameter("cbCateId");
        String createDate = request.getParameter("start");
        String expiredDate = request.getParameter("end");
        String image = request.getParameter("txtImage");
        if (image != null) {
            if (image.equals("")) {
                image = request.getParameter("txtImg");
            }
        }
        String status = request.getParameter("cbStatus");

        try {
            int role = -1;
            HttpSession session = request.getSession(false);
            if (session != null) {
                if (session.getAttribute("ROLE") != null) {
                    role = (int) session.getAttribute("ROLE");
                    String userId = (String) session.getAttribute("USER_ID");
                    if (role == 1) {
                        java.util.Date start = new SimpleDateFormat("yyyy-MM-dd").parse(createDate);
                        java.util.Date end = new SimpleDateFormat("yyyy-MM-dd").parse(expiredDate);
                        boolean dateCheck = start.before(end);

                        if (dateCheck) {

                            TblProductDAO dao = new TblProductDAO();
                            TblProductDTO dto = new TblProductDTO(Integer.parseInt(id), name,
                                    Double.parseDouble(price), Integer.parseInt(quantity),
                                    Integer.parseInt(cateId), image, "", createDate, expiredDate, status);
                            boolean result = dao.updateCake(dto);
                            if (result) {
                                TblLogDAO logDao = new TblLogDAO();

                                long millis = System.currentTimeMillis();
                                Date date = new Date(millis);
                                result = logDao.addLog(new TblLogDTO(1, userId,
                                        Integer.parseInt(id), date + ""));
                                if (result) {
                                    String urlRewriting = "ShowDetail?txtProId=" + id;
                                    url = urlRewriting;
                                }
                            }
                        } else {
                            String urlRewriting = "ShowDetail?txtProId=" + id + "&er=true";
                            url = urlRewriting;
                        }
                    }
                }
            }

        } catch (ParseException ex) {
            LOGGER.info("UpdateCakeServlet _ Parse: " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.info("UpdateCakeServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("UpdateCakeServlet _ Naming: " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
