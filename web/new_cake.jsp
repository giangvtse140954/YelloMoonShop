<%-- 
    Document   : new_cake
    Created on : Oct 13, 2020, 2:05:54 PM
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
        <c:set var="role" value="${sessionScope.ROLE}"/>
        <c:if test="${role != 1}">
            <c:redirect url="${home}"/>
        </c:if>

        <c:if test="${role == 1}">
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
                        <c:if test="${role == 1}">
                            <li class="nav-item active">
                                <c:set var="urlCreate" value="GoToCreate"/>
                                <a class="nav-link" href="${urlCreate}">Create</a>
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
                </div>
            </nav>
            <!--end of navigation bar-->

            <c:set var="fullname" value="${sessionScope.NAME}"/> 
            <h4>${fullname}</h4>

            <!--begin of form to post cake-->
            <div class="container-fluid bg">
                <div class="row justify-content-center">
                    <div class="col-12 col-sm-6 col-md-3">
                        <form action="CreateNewCake" method="POST" class="form-container" style="margin-bottom: 60px">
                            <h2 class="text-center">Create Cake</h2>
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" placeholder="Trung thu am ap" name="txtName" value="" required maxlength="100">
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <input type="text" class="form-control" placeholder="vai dieu ve cai banh nay..." name="txtDes" value="" required maxlength="200">
                            </div>
                            <div class="form-group">
                                <label>Price</label>
                                <input type="number" class="form-control" placeholder="0.00" name="txtPrice" step="0.01" required="">
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <input type="number" class="form-control" placeholder="1, 2, 3" name="txtQuantity" required="">
                            </div>
                            <c:set var="date" value="${requestScope.DATE}"/>
                            <div class="form-group">
                                <label for="start">Create date </label>
                                <input type="date" id="start" name="start"
                                       value="${date}"
                                       min="2017-01-01" max="2030-12-31">
                            </div>
                            <div class="form-group">
                                <label for="start">Expired date </label>
                                <input type="date" id="end" name="end"
                                       value="${date}"
                                       min="2020-01-01" max="2030-12-31">
                            </div>
                            <div class="form-group">
                                <select class="custom-select custom-select-sm" name="cbCateId" id="cate">
                                    <c:forEach items="${requestScope.CATE_LIST}" var="cateDto">
                                        <option value="${cateDto.cateId}">${cateDto.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="exampleFormControlFile1">File input</label>
                                <input type="file" class="form-control-file" id="exampleFormControlFile1" name="txtImage" accept=".jpg,.gif,.png" required>
                            </div>
                            <input type="submit" value="Create" name="btAction" class="btn btn-outline-primary"/>
                            <c:set var="err" value="${param.err}"/>
                            <c:if test="${not empty err}">
                                <small style="color: red">Date is not valid.</small>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
            <!--end of form to post cake-->
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </body>
</html>
