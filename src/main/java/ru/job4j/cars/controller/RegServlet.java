package ru.job4j.cars.controller;

import ru.job4j.cars.dao.UserDao;
import ru.job4j.cars.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RegServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = new User(name, phone, email, password);
        try {
            UserDao.instOf().save(user);
            HttpSession sc = req.getSession();
            sc.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/index");
        } catch (Exception e) {
            req.setAttribute("error", "Пользователь с таким e-mail уже существует");
            req.getRequestDispatcher("/view/reg.jsp").forward(req, resp);
        }
    }
}
