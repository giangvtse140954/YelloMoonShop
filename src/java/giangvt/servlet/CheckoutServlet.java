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
import giangvt.tblproduct.TblProductDAO;
import giangvt.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Map;
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
public class CheckoutServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(CheckoutServlet.class);
    private final String ERROR_PAGE = "error.jsp";
//    private final String 

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
        String userId;
        String phone;
        String addr;
        String name;
        double total;
        boolean checkRole = true;

        String t = request.getParameter("txtTotal");
        boolean isExisted = true;
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                if (session.getAttribute("CART") != null) {
                    if (session.getAttribute("ROLE") != null) {
                        int role = (int) session.getAttribute("ROLE");
                        if (role == 1) {
                            checkRole = false;
                        }
                    }
                    if (checkRole) {
                        CartObject cart = (CartObject) session.getAttribute("CART");

                        // check available product in cart
                        Map<Integer, TblProductDTO> items = cart.getItems();
                        TblProductDAO proDao = new TblProductDAO();
                        for (Integer key : items.keySet()) {
                            // product in database
                            TblProductDTO pro = proDao.getProductById(key);
                            if (pro.getQuantity() < items.get(key).getQuantity()
                                    || items.get(key).getStatus().equals("Deactive")) {
                                isExisted = false;
                            }
                        }
                        if (isExisted) {
                            if (session.getAttribute("USER_ID") != null) {
                                userId = (String) session.getAttribute("USER_ID");
                                phone = (String) session.getAttribute("PHONE");
                                addr = (String) session.getAttribute("ADDR");
                                name = (String) session.getAttribute("NAME");

                                total = (double) Double.parseDouble(t);
                            } else {
                                userId = null;
                                name = request.getParameter("txtName");
                                addr = request.getParameter("txtAddr");
                                phone = request.getParameter("txtPhone");

                                total = Double.parseDouble(request.getParameter("txtTotal"));
                            }
                            TblOrderDAO dao = new TblOrderDAO();
                            LocalDateTime now = LocalDateTime.now();

                            TblOrderDTO dto = new TblOrderDTO(null, userId, total, now + "",
                                    name, addr, "delivering", phone);

                            // check existed order
                            UUID id = null;
                            if (userId != null) {
                                id = dao.getKey(dto);
                            } else {
                                id = dao.getKey(now + "", total, addr, "delivering", phone, name);
                            }

                            if (id == null) {
                                boolean check = dao.addOrder(dto);
                                if (check) {
                                    if (userId != null) {
                                        id = dao.getKey(dto);
                                    } else {
                                        id = dao.getKey(now + "", total, addr, "delivering", phone, name);
                                    }
                                    TblOrderDetailDAO detailDao = new TblOrderDetailDAO();
                                    for (Integer key : items.keySet()) {
                                        check = detailDao.addDetail(id, items.get(key).getProId(),
                                                items.get(key).getPrice(), items.get(key).getQuantity());
                                        if (check) {
                                            int quantity = proDao.getProductById(key).getQuantity()
                                                    - items.get(key).getQuantity();
                                            if (quantity == 0) {
                                                check = proDao.updateCake(items.get(key).getProId(),
                                                        quantity, "Deactive");
                                            } else {
                                                check = proDao.updateCake(items.get(key).getProId(),
                                                        quantity, "Active");
                                            }
                                            if (check) {
                                                request.setAttribute("ORDER", cart);
                                                session.setAttribute("CART", null);
                                                String urlRewriting = "order_detail.jsp?date=" + now
                                                        + "&id=" + id + "&name=" + name + "&addr=" + addr;
                                                url = urlRewriting;
                                            }
                                        }
                                    }
                                }
                            }

                        }

                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.info("CheckoutServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("CheckoutServlet _ Naming: " + ex.getMessage());
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
