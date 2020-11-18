/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package giangvt.servlet;

import giangvt.cart.CartObject;
import giangvt.tblproduct.TblProductDAO;
import giangvt.tblproduct.TblProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;
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
public class AddToCartServlet extends HttpServlet {

    private final Logger LOGGER = Logger.getLogger(AddToCartServlet.class);
    private final String ERROR_PAGE = "error.jsp";
    private final String SEARCH_CONTROLLER = "SearchCake";
    private final String VIEW_CART_PAGE = "view_cart.jsp";

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
        boolean checkRole = true;

        try {
            HttpSession session = request.getSession();
            CartObject cart = (CartObject) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartObject();
            }

            if (session.getAttribute("ROLE") != null) {
                int role = (int) session.getAttribute("ROLE");
                if (role == 1) {
                    checkRole = false;
                }
            }

            if (checkRole) {
                String id = request.getParameter("txtProId");
                if (id != null) {
                    if (id.matches("\\d+")) {
                        TblProductDAO dao = new TblProductDAO();
                        TblProductDTO dto = dao.getProductById(Integer.parseInt(id));
                        if (dto != null) {
                            // kiem tra xem co con trong stock khong
                            String status = dto.getStatus();
                            int quantity = dto.getQuantity();
                            if (status.equals("Active") && quantity > 0) {
                                url = SEARCH_CONTROLLER;
                                Map<Integer, TblProductDTO> items = cart.getItems();
                                if (items != null) {
                                    TblProductDTO item = items.get(dto.getProId());
                                    if (item != null) {
                                        if (quantity > item.getQuantity()) {
                                            cart.addItemToCart(dto);
                                            session.setAttribute("CART", cart);
                                            String urlRewriting = "SearchCake?noti=" + dto.getName();
                                            url = urlRewriting;
                                        }
                                    } else {
                                        cart.addItemToCart(dto);
                                        session.setAttribute("CART", cart);
                                        String urlRewriting = "SearchCake?noti=" + dto.getName();
                                        url = urlRewriting;
                                    }
                                } else {
                                    cart.addItemToCart(dto);
                                    session.setAttribute("CART", cart);
                                    String urlRewriting = "SearchCake?noti=" + dto.getName();
                                    url = urlRewriting;
                                }
                                String view = request.getParameter("view");
                                if (view != null) {
                                    url = VIEW_CART_PAGE;
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.info("AddToCartServlet _ SQL: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("AddToCartServlet _ Naming: " + ex.getMessage());
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
