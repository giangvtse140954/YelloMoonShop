<%-- 
    Document   : error
    Created on : Oct 11, 2020, 3:05:03 PM
    Author     : MY HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%@page session="false"%>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>YMS</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>

        <div style="text-align: center; margin-top: 100px">
            <img src="https://img.icons8.com/clouds/2x/box-important.png" style="max-width: 200px"/>
            <h1>Oops</h1>
            <h5>Something went wrong.</h5>
            <c:set var="urlGo" value="SearchCake"/>
            <a href="${urlGo}">Go back to home page.</a>
        </div>
    </body>
</html>
