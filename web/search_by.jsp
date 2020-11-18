<%-- 
    Document   : search_by
    Created on : Oct 11, 2020, 11:10:22 AM
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

                    <!--search-->
                    <li class="nav-item active">
                        <a class="nav-link" href="">Search</a>
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
        <c:set var="fullname" value="${sessionScope.NAME}"/> 
        <h4>${fullname}</h4>
        <!--begin of form to search cake-->
        <div class="container-fluid bg">
            <div class="row justify-content-center">
                <div class="col-12 col-sm-6 col-md-3">
                    <form action="SearchCake" class="form-container">
                        <h2 class="text-center">Search Cakes</h2>
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" class="form-control" placeholder="Trung thu am ap" name="txtName" value="">
                        </div>
                        <c:set var="max" value="${requestScope.MAX}"/>
                        <div class="form-group">
                            <label for="customRange2">Min price</label>
                            <input type="range" class="custom-range" min="0" max="${max + 1}" id="customRange2" name="txtLow">
                        </div>
                        <div class="form-group">
                            <label for="customRange2">Max price</label>
                            <input type="range" class="custom-range" min="0" max="${max + 1}" id="customRange2" name="txtHigh">
                        </div>
                        <div class="form-group">
                            <select class="custom-select custom-select-sm" name="cbCateId">
                                <option selected value="-1">Select category</option>
                                <c:forEach items="${requestScope.CATE_LIST}" var="dto">
                                    <option value="${dto.cateId}">${dto.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="submit" value="Search" class="btn btn-outline-primary"/>
                    </form>
                </div>
            </div>
        </div>
        <!--end of form to search cake-->


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
