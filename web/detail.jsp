<%-- 
    Document   : update
    Created on : Oct 11, 2020, 10:35:06 PM
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
        <c:set var="roleId" value="${sessionScope.ROLE}"/>

        <c:set var="home" value="SearchCake"/>
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
                        <c:set var="urlSearch" value="GoToSearch"/>
                        <a class="nav-link" href="${urlSearch}">Search</a>
                    </li>

                    <!--create-->
                    <c:if test="${roleId == 1}">
                        <li class="nav-item active">
                            <c:set var="urlCreate" value="GoToCreate"/>
                            <a class="nav-link" href="${urlCreate}">Create</a>
                        </li>
                    </c:if>

                    <!--view cart-->
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

        <!--update here-->
        <c:set var="dto" value="${requestScope.DTO}"/>
        <c:set var="cateList" value="${requestScope.CATE_LIST}"/>
        <c:set var="cate" value="${requestScope.CATE}"/>
        <form action="UpdateCake" method="post">
            <div class="container">
                <div class="row detail">
                    <div class="col-6">
                        <img src="images/${dto.image}" class="image-detail"/>
                        <c:if test="${roleId == 1}">
                            <input type="submit" value="Update" class="btn btn-outline-primary btn-sm"/>
                            <c:set var="err" value="${param.er}"/>
                            <c:if test="${err}">
                                <small style="color: red">Date is not valid.</small>
                            </c:if>
                        </c:if>
                    </div>
                    <div class="col-6">
                        <h2 class="text-center">Detail Cake</h2>
                        <div class="form-group">
                            <label>Name</label>
                            <input type="text" class="form-control tatno" placeholder="Trung thu am ap" name="txtName" value="${dto.name}" required maxlength="100">
                            <input type="hidden" name="txtProId" value="${dto.proId}" />
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlFile1">Image</label>
                            <input type="file" class="form-control-file tatno" id="exampleFormControlFile1" name="txtImage">
                            <input type="hidden" name="txtImg" value="${dto.image}" />
                        </div>
                        <div class="form-group">
                            <label>Price</label>
                            <input type="number" class="form-control tatno" placeholder="0.00" name="txtPrice" step="0.01" value="${dto.price}" required="">
                        </div>
                        <div class="form-group">
                            <label>Quantity</label>
                            <input type="number" class="form-control tatno" placeholder="1, 2, 3" name="txtQuantity" value="${dto.quantity}" required="">
                        </div>
                        <div class="form-group">
                            <label for="start">Create date </label>
                            <input type="date" id="start" name="start"
                                   value="${dto.createDate}"
                                   min="2017-01-01" max="2030-12-31">
                        </div>
                        <div class="form-group">
                            <label for="start">Expired date </label>
                            <input type="date" id="end" name="end"
                                   value="${dto.expiredDate}"
                                   min="2020-01-01" max="2030-12-31">
                        </div>
                        <div class="form-group">
                            <select class="custom-select custom-select-sm" name="cbCateId" id="cate">
                                <c:forEach items="${requestScope.CATE_LIST}" var="cateDto">
                                    <c:if test="${cateDto.name == cate}">
                                        <option selected value="${cateDto.cateId}">${cateDto.name}</option>
                                    </c:if>

                                    <c:if test="${cateDto.name != cate}">
                                        <option value="${cateDto.cateId}">${cateDto.name}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <select class="custom-select custom-select-sm" name="cbStatus" id="status">
                                <c:if test="${dto.status == 'Active'}">
                                    <option selected value="Active">Active</option>
                                    <option value="Deactive">Deactive</option>
                                </c:if>
                                <c:if test="${dto.status == 'Deactive'}">
                                    <option selected value="Deactive">Deactive</option>
                                    <option value="Active">Active</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!--end update-->

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

        <c:if test="${roleId != 1}">
            <script>

                var x = document.getElementsByClassName("tatno");
                for (var i = 0; i < x.length; i++) {
                    x[i].readOnly = true;
                }
                document.getElementById("start").disabled = true;
                document.getElementById("end").disabled = true;
                document.getElementById("status").disabled = true;
                document.getElementById("cate").disabled = true;
                document.getElementById("exampleFormControlFile1").disabled = true;
            </script> 
        </c:if>
    </body>
</html>
