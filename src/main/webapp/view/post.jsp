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

<div class="container pt-3">
    <div class="row justify-content-center text-end">
        <div class="col-5">
            <p><c:out value="${user.name}"/> | <a href="<c:url value="/logout"/>">Выйти</a></p>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-5">
            <div class="card">
                <div class="card-header">
                    Новое объявление
                </div>
                <div class="card-body">
                    <form action="<c:url value="/post"/>" method="post" enctype="multipart/form-data">
                        <div class="form-group mb-3">
                            <label for="brand" class="form-label">Бренд</label>
                            <select class="form-select" id="brand" name="brand" title="Выберите бренд автомобиля">
                                <option value="" selected>Выберите бренд автомобиля</option>
                                <c:forEach items="${brands}" var="brand">
                                    <option value='<c:out value="${brand.id}"/>'><c:out value="${brand.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="model" class="form-label">Модель</label>
                            <input type="text" class="form-control" id="model" name="model" placeholder="Укажите модель автомобиля">
                        </div>
                        <div class="form-group mb-3">
                            <label for="body" class="form-label">Тип кузова</label>
                            <select class="form-select" id="body" name="body" title="Выберите тип кузова автомобиля">
                                <option value="" selected>Выберите тип кузова автомобиля</option>
                                <c:forEach items="${bodies}" var="body">
                                    <option value='<c:out value="${body.id}"/>'><c:out value="${body.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="color" class="form-label">Цвет</label>
                            <select class="form-select" id="color" name="color" title="Выберите цвет автомобиля">
                                <option value="" selected>Выберите цвет автомобиля</option>
                                <c:forEach items="${colors}" var="color">
                                    <option value='<c:out value="${color.id}"/>'><c:out value="${color.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group mb-3">
                            <label for="year" class="form-label">Год</label>
                            <input class="form-control" id="year" name="year" placeholder="Укажите год выпуска автомобиля">
                        </div>
                        <div class="form-group mb-3">
                            <label for="price" class="form-label">Цена</label>
                            <input class="form-control" id="price" name="price" placeholder="Укажите стоимость автомобиля">
                        </div>
                        <div class="form-group mb-3">
                            <label for="description" class="form-label">Описание</label>
                            <textarea class="form-control" id="description" name="description" placeholder="Добавьте описание автомобиля"></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label for="photo" class="form-label">Фото</label><br>
                            <input type="file" id="photo" name="photo" multiple>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary" onclick="return validate()">Разместить объявление</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript scripts -->
<script>
    function validate() {
        let brand = $('#brand').val();
        let model = $('#model').val();
        let body = $('#body').val();
        let color = $('#color').val();
        let year = $('#year').val();
        let price = $('#price').val();
        let description = $('#description').val();

        if (brand === "") {
            alert($('#brand').attr('title'));
            return false;
        }
        if (model === "") {
            alert($('#model').attr('placeholder'));
            return false;
        }
        if (body === "") {
            alert($('#body').attr('title'));
            return false;
        }
        if (color === "") {
            alert($('#color').attr('title'));
            return false;
        }
        if (year === "") {
            alert($('#year').attr('placeholder'));
            return false;
        }
        if (price === "") {
            alert($('#price').attr('placeholder'));
            return false;
        }
        if (description === "") {
            alert($('#description').attr('placeholder'));
            return false;
        }
        return true;
    }
</script>
</body>
</html>
