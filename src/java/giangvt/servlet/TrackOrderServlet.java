/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.servlet;

import giangvt.cart.CartObject;
import giangvt.tblorder.TblOrderDAO;
import giangvt.tblorder.TblOrderDTO;
import giangvt.tblorderdetail.TblOrderDetailDAO;
import giangvt.tblorderdetail.TblOrderDetailDTO;
import giangvt.tblproduct.TblProductDAO;
import giangvt.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
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
public class TrackOrderServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(TrackOrderServlet.class);
    private final String ERROR_PAGE = "error.jsp";
    private final String DETAIL_ORDER_PAGE = "order_detail.jsp";

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

        String searchValue = request.getParameter("txtSearchValue");
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                if (session.getAttribute("ROLE") != null) {
                    int role = (int) session.getAttribute("ROLE");
                    if (role == 2) {
                        String userId = (String) session.getAttribute("USER_ID");
                        UUID id = null;
                        boolean checkValid = true;
                        if (searchValue != null) {
                            try {
                                id = UUID.fromString(searchValue.trim());
                            } catch (IllegalArgumentException ex) {
                                checkValid = false;
                                url = DETAIL_ORDER_PAGE;
                            }
                            if (checkValid) {
                                TblOrderDAO dao = new TblOrderDAO();
                                TblOrderDTO dto = dao.searchOrder(id, userId);
                                if (dto != null) {
                                    TblOrderDetailDAO deDao = new TblOrderDetailDAO();
                                    List<TblOrderDetailDTO> list = deDao.getDetail(dto.getOrderId());
                                    if (list != null) {
                                        TblProductDAO proDao = new TblProductDAO();
                                        TblProductDTO flag = null;
                                        CartObject cart = new CartObject();
                                        for (TblOrderDetailDTO pro : list) {
                                            flag = proDao.getProductById(pro.getProId());
                                            if (flag != null) {
                                                flag.setQuantity(pro.getQuantity());
                                                cart.addOrder(flag);
                                            }
                                        }
                                        request.setAttribute("ORDER", cart);
                                        String urlRewriting = "order_detail.jsp?date=" + dto.getDate()
                                                + "&id=" + dto.getOrderId() + "&name=" + dto.getName() 
                                                + "&addr=" + dto.getAddress();
                                        log(dto.getName());
                                        url = urlRewriting;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.info("TrackOrderServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("TrackOrderServlet _ Naming: " + ex.getMessage());
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
