<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>


<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Favicon -->
    <link rel="shortcut icon" href="/job4j_todo/img/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

    <title>Cars</title>
</head>
<body>
<!--jQuery-->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

<div class="container-fluid pt-3">
    <div class="row mb-3">
        <div class="col text-end">
            <c:if test="${user == null}">
                Гость | <a href="<c:url value="/view/login.jsp"/>">Войти</a>
            </c:if>
            <c:if test="${user != null}">
                <p><c:out value="${user.name}"/> | <a href="<c:url value="/logout"/>">Выйти</a></p>
                <a class="btn btn-primary" role="button" href="<c:url value="/post"/>">Новое объявление</a>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-header">
                    Объявления
                </div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col">Автомобиль</th>
                            <th scope="col" class="col-3">Описание</th>
                            <th scope="col">Фото</th>
                            <th scope="col">Контакты</th>
                            <th scope="col">Дата создания</th>
                            <th scope="col">Статус</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${posts}" var="post">
                            <tr>
                                <td>
                                    <ul>
                                        <li>
                                            <b>Бренд:</b> <c:out value="${post.car.brand.name}"/>
                                        </li>
                                        <li>
                                            <b>Модель:</b> <c:out value="${post.car.model}"/>
                                        </li>
                                        <li>
                                            <b>Кузов:</b> <c:out value="${post.car.body.name}"/>
                                        </li>
                                        <li>
                                            <b>Цвет:</b> <c:out value="${post.car.color.name}"/>
                                        </li>
                                        <li>
                                            <b>Год выпуска:</b> <c:out value="${post.car.year}"/>
                                        </li>
                                        <li>
                                            <b>Цена:</b> <c:out value="${post.car.price}"/>
                                        </li>
                                    </ul>
                                </td>
                                <td>
                                    <c:out value="${post.description}"/>
                                </td>
                                <td>
                                    <c:forEach items="${post.photos}" var="photo">
                                        <div class="mb-1">
                                            <img src="<c:url value='/photo?name=${photo.name}'/>" width="300px" height="200px"
                                                 alt="Фото автомобиля"/>
                                        </div>
                                    </c:forEach>
                                </td>
                                <td>
                                    <ul>
                                        <li>
                                            <b>Автор:</b> <c:out value="${post.user.name}"/>
                                        </li>
                                        <li>
                                            <b>Телефон:</b> <c:out value="${post.user.phone}"/>
                                        </li>
                                        <li>
                                            <b>Почта:</b> <c:out value="${post.user.email}"/>
                                        </li>
                                    </ul>
                                </td>
                                <td>
                                    <fmt:formatDate value="${post.created}" pattern="dd MMMM yyyy"/>
                                </td>
                                <td>
                                    <c:if test="${post.isSold}">
                                        <p class="btn btn-outline-danger btn-sm active">Продано</p>
                                    </c:if>
                                    <c:if test="${!post.isSold}">
                                        <p class="btn btn-outline-success btn-sm active">В продаже</p>
                                        <c:if test="${post.user eq user}">
                                            <form action="<c:url value="/sold"/>" method="post">
                                                <div class="form-group">
                                                    <input type="hidden" name="postId" value="<c:out value="${post.id}"/>">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm">Снять с продажи</button>
                                                </div>
                                            </form>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
