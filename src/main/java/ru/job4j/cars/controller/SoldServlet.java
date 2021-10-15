package ru.job4j.cars.controller;

import ru.job4j.cars.dao.PostDao;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SoldServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        int postId = Integer.parseInt(req.getParameter("postId"));
        PostDao.instOf().updatePostAsSold(postId);
        resp.sendRedirect(req.getContextPath() + "/index");
    }
}
