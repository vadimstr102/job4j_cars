<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

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

<div class="container">
    <div class="row justify-content-center pt-3">
        <div class="col-3">
            <div class="card">
                <div class="card-header">
                    Регистрация
                </div>
                <div class="card-body">
                    <form action="<c:url value="/reg"/>" method="post">
                        <div class="form-group mb-3">
                            <label for="username" class="form-label">Имя</label>
                            <input type="text" class="form-control" id="username" name="name" placeholder="Введите имя пользователя">
                        </div>
                        <div class="form-group mb-3">
                            <label for="phone" class="form-label">Номер телефона</label>
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="Введите номер телефона">
                        </div>
                        <div class="form-group mb-3">
                            <label for="email" class="form-label">Почта</label>
                            <input type="text" class="form-control" id="email" name="email" placeholder="Введите адрес почты">
                        </div>
                        <div class="form-group mb-4">
                            <label for="password" class="form-label">Пароль</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Введите пароль">
                        </div>
                        <div class="form-group d-grid mb-3">
                            <button type="submit" class="btn btn-primary" onclick="return validate()">Зарегистрироваться</button>
                        </div>
                        <c:if test="${requestScope.error != null}">
                            <div style="color:red; font-weight: bold; margin: 30px 0;">
                                <c:out value="${requestScope.error}"/>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript scripts -->
<script>
    function validate() {
        let userName = $('#username').val();
        let phone = $('#phone').val();
        let email = $('#email').val();
        let password = $('#password').val();

        if (userName === "") {
            alert($('#username').attr('placeholder'));
            return false;
        }
        if (phone === "") {
            alert($('#phone').attr('placeholder'));
            return false;
        }
        if (email === "") {
            alert($('#email').attr('placeholder'));
            return false;
        }
        if (password === "") {
            alert($('#password').attr('placeholder'));
            return false;
        }
        return true;
    }
</script>
</body>
</html>
