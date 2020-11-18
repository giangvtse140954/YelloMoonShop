<%-- 
    Document   : order_detail
    Created on : Oct 16, 2020, 12:11:01 PM
    Author     : MY HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>YMS</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css"/>
    </head>
    <body>
        <c:set var="home" value="SearchCake"/>
        <c:set var="roleId" value="${sessionScope.ROLE}"/>


        <c:if test="${roleId == 1}">
            <c:redirect url="${home}"/>
        </c:if>

        <c:if test="${roleId != 1}">
            <!--navbar here-->
            <nav class="navbar navbar-expand-lg navbar-light fixed-top">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a class="navbar-brand" href="${home}">YMS</a>

                <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                        <li class="nav-item active">
                            <a class="nav-link" href="${home}">Home <span class="sr-only">(current)</span></a>
                        </li>

                        <!--search here-->
                        <c:set var="urlSearchPage" value="GoToSearch"/>
                        <li class="nav-item active">
                            <a class="nav-link" href="${urlSearchPage}">Search</a>
                        </li>

                        <!--create-->
                        <c:if test="${roleId == 1}">
                            <li class="nav-item active">
                                <c:set var="urlCreate" value="GoToCreate"/>
                                <a class="nav-link" href="${urlCreate}">Create</a>
                            </li>
                        </c:if>

                        <c:if test="${roleId != 1}">
                            <li class="nav-item active">
                                <c:set var="urlViewCart" value="view_cart.jsp"/>
                                <a class="nav-link" href="${urlViewCart}">View cart</a>
                            </li>
                        </c:if>

                        <!--logout here-->
                        <c:set var="urlLogout" value="Logout"/>
                        <li class="nav-item active">
                            <a class="nav-link" href="${urlLogout}">Logout</a>
                        </li>

                        <!--login here-->
                        <c:set var="urlLogin" value="login.html"/>
                        <li class="nav-item active">
                            <a class="nav-link" href="${urlLogin}">Login</a>
                        </li>
                    </ul>

                    <c:if test="${roleId == 2}">
                        <form class="form-inline my-2 my-lg-0" action="TrackOrder">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search Order" aria-label="Search"
                                   name="txtSearchValue" value="${searchValue}" required>
                            <input type="submit" class="btn btn-outline-primary my-2 my-sm-0" name="Search"/>
                        </form>
                    </c:if>
                </div>
            </nav>
            <!--end of navigation bar-->
            
            
            <!--view cart-->
            <c:set var="order" value="${requestScope.ORDER}"/>

            <c:if test="${empty order}">
                <!--when there is no result cart-->
                <div id="noResult">
                    <img src="https://www.it-camera.com/themes/belgrade/assets/images/shopping-cart-empty.svg"/>
                    <h3>Your order does not existed</h3>
                    <h5>Make sure you have added cake to cart already to make me happy :></h5>
                </div>
            </c:if>
            <!--end of no result-->

            <c:if test="${not empty order}">
                <div class="container mb-4">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="text-center">Order Detail</h2>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th scope="col">Name</th>
                                            <th scope="col" class="text-center">Quantity</th>
                                            <th scope="col" class="text-right">Price</th>
                                            <th scope="col" class="text-right">Total price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="items" value="${order.items}"/>
                                        <c:set var="total" value="0"/>
                                        <c:forEach var="cake" items="${items}">
                                            <c:set var="dto" value="${cake.value}"/>
                                            <tr>
                                                <td>${dto.name}</td>
                                                <td class="text-center">${dto.quantity}</td>
                                                <td class="text-right">${dto.price}₫</td>
                                                <td class="text-right">${dto.price * dto.quantity}₫</td>
                                            </tr>
                                            <c:set var="total" value="${total + (dto.price * dto.quantity)}"/>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                    <hr/>
                                    <c:set var="date" value="${param.date}"/>
                                    <c:set var="id" value="${param.id}"/>
                                    <c:set var="name" value="${param.name}"/>
                                    <c:set var="addr" value="${param.addr}"/>
                                    <p>Order ID: ${id}</p>
                                    <p>Customer: ${name}</p>
                                    <p>Address: ${addr}</p>
                                    <h4><b>Total: ${total}₫</b></h4>
                                    <small>${date}</small>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
