<%-- 
    Document   : view_cart
    Created on : Oct 14, 2020, 11:16:59 PM
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
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css"/>
    </head>
    <body>
        <c:set var="roleId" value="${sessionScope.ROLE}"/>
        <c:set var="home" value="SearchCake"/>

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
            <c:set var="cart" value="${sessionScope.CART}"/>
            <c:if test="${empty cart}">
                <!--when there is no result cart-->
                <div id="noResult">
                    <img src="https://www.it-camera.com/themes/belgrade/assets/images/shopping-cart-empty.svg"/>
                    <h3>Your cart is empty</h3>
                    <h5>Make sure you have added cake to cart already to make me happy :></h5>
                </div>
            </c:if>
            <!--end of no result-->

            <c:if test="${not empty cart}">
                <form action="Checkout" method="POST">
                    <div class="container mb-4">
                        <div class="row">
                            <div class="col-12">
                                <h2 class="text-center">Checkout</h2>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Name</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col" class="text-right">Price</th>
                                                <th scope="col" class="text-right">Total price</th>
                                                <th> </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="items" value="${cart.items}"/>
                                            <c:set var="total" value="0"/>
                                            <c:forEach var="cake" items="${items}">
                                                <c:set var="dto" value="${cake.value}"/>
                                                <tr>
                                                    <td>${dto.name}</td>
                                                    <c:url var="urlAdd" value="AddToCart">
                                                        <c:param name="txtProId" value="${dto.proId}"/>
                                                        <c:param name="view" value="true"/>
                                                    </c:url>
                                                    <c:url var="urlSub" value="SubtractCake">
                                                        <c:param name="txtProId" value="${dto.proId}"/>
                                                    </c:url>
                                                    <td><a href="${urlSub}">-</a>${dto.quantity}<a href="${urlAdd}">+</a></td>
                                                    <td class="text-right">${dto.price}₫</td>
                                                    <td class="text-right">${dto.price * dto.quantity}₫</td>
                                                    <c:url var="urlDelete" value="DeleteCake">
                                                        <c:param name="txtProId" value="${dto.proId}"/>
                                                    </c:url>
                                                    <td class="text-right"><a class="btn btn-sm btn-danger" href="${urlDelete}" onclick="return confirm('Are you sure you want to delete?')"><i class="fa fa-trash"></i></a></td>
                                                </tr>
                                                <c:set var="total" value="${total + (dto.price * dto.quantity)}"/>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot>
                                        <hr/>
                                        <h4><b>Total: ${total}₫</b></h4>
                                        <input type="hidden" name="txtTotal" value="${total}" />
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <div class="col mb-2">
                                <div class="row">
                                    <div class="col-sm-12  col-md-6">
                                        <a href="${home}" class="btn btn-block btn-light">Continue Shopping</a>
                                    </div>

                                    <c:if test="${not empty roleId}">
                                        <div class="col-sm-12 col-md-6 text-right">
                                            <input class="btn btn-lg btn-block btn-outline-primary" type="submit" value="Checkout" />
                                        </div>
                                    </c:if>
                                    <c:if test="${empty roleId}">
                                        <div class="col-sm-12 col-md-6 text-right">
                                            <c:url var="urlInfo" value="info.jsp">
                                                <c:param name="txtTotal" value="${total}"/>
                                            </c:url>
                                            <a class="btn btn-lg btn-block btn-outline-primary" href="${urlInfo}">Checkout</a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </c:if>
        </c:if>


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
