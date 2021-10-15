package ru.job4j.cars.controller;

import ru.job4j.cars.dao.PostDao;
import ru.job4j.cars.model.Post;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Post> posts = PostDao.instOf().findAllPosts();
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/view/index.jsp").forward(req, resp);
    }
}
