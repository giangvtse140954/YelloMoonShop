<%-- 
    Document   : show_order
    Created on : Oct 16, 2020, 8:01:00 PM
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


            <!--show order start-->

            <!--show order end-->
        </c:if>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
