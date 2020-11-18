<%-- 
    Document   : search
    Created on : Oct 7, 2020, 11:06:57 PM
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
        <c:set var="fullname" value="${sessionScope.NAME}"/> 
        <h4>${fullname}</h4>
        <c:set var="noti" value="${param.noti}"/>
        <c:if test="${not empty noti}">
            <div class="alert alert-primary" role="alert" style="margin: 70px 300px 0px 300px">
                Add <b>${noti}</b> to cart successfully
            </div>
        </c:if>

        <!--get list product here-->
        <c:set var="list" value="${requestScope.LIST}"/>
        <c:set var="names" value="${requestScope.NAMES}"/>

        <div class="row row-cols-1 row-cols-md-3">
            <c:forEach items="${list}" var="dto" varStatus="counter">
                <div class="col mb-4">
                    <div class="card">
                        <img src="./images/${dto.image}" class="card-img-top" alt="Image"/>
                        <div class="card-body">
                            <h5 class="card-title"><b>${dto.name}</b></h5>
                            <p class="card-text">${dto.description}</p>
                            <p class="card-text">${names[counter.index]}</p>
                            <p class="card-text"><b>${dto.price}₫</b></p>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center">
                        <c:url var="urlDetail" value="ShowDetail">
                            <c:param name="txtProId" value="${dto.proId}"/>
                        </c:url>
                        <c:if test="${roleId != 1}">
                            <a href="${urlDetail}" class="btn btn-outline-primary btn-sm">Detail</a>
                        </c:if>
                        <c:if test="${roleId == 1}">
                            <a href="${urlDetail}" class="btn btn-outline-primary btn-sm">Update</a>
                        </c:if>

                        <c:if test="${dto.status == 'Active' && dto.quantity > 0 && roleId != 1}">
                            <c:url var="urlAdd" value="AddToCart">
                                <c:param name="txtProId" value="${dto.proId}"/>
                            </c:url>
                            <a href="${urlAdd}" class="btn btn-outline-primary btn-sm">Add to cart</a>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!--end of list product-->

        <!--when there is no result matched-->
        <c:set var="list" value="${requestScope.LIST}"/>
        <c:if test="${empty list}">
            <div id="noResult">
                <img src="https://www.iconfinder.com/data/icons/facebook-and-social-media-1/64/Facebook_and_Social_Media-17-512.png"/>
                <h3>We didn't find any results</h3>
                <h5>Make sure everything is spelled correctly or try different keywords.</h5>
            </div>
        </c:if>
        <!--end of no matched-->

        <c:if test="${not empty list}">
            <!--start paging-->
            <c:set var="page" value="${requestScope.PAGE}"/>
            <c:url var="urlNext" value="ChangeNextPage">
                <c:param name="page" value="${page}"/>
                <c:param name="txtName" value="${param.txtName}"/>
                <c:param name="txtHigh" value="${param.txtHigh}"/>
                <c:param name="txtLow" value="${param.txtLow}"/>
                <c:param name="cbCateId" value="${param.cbCateId}"/>
            </c:url>
            <c:url var="urlPre" value="ChangePrePage">
                <c:param name="page" value="${page}"/>
                <c:param name="txtName" value="${param.txtName}"/>
                <c:param name="txtHigh" value="${param.txtHigh}"/>
                <c:param name="txtLow" value="${param.txtLow}"/>
                <c:param name="cbCateId" value="${param.cbCateId}"/>
            </c:url>


            <!--paging-->
            <nav aria-label="Page navigation example">
                <ul class="pagination d-flex justify-content-center">
                    <li class="page-item"><a class="page-link" href="${urlPre}">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="${urlNext}">Next</a></li>
                </ul>
            </nav>
            <!--end of paging-->
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
