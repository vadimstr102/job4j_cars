package ru.job4j.cars.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Properties;

public class PhotoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        Properties cfg = new Properties();
        try (
                InputStream inputStream = getClass().getClassLoader().getResourceAsStream("photo.properties")
        ) {
            cfg.load(inputStream);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        File downloadFile = null;
        for (File file : new File(cfg.getProperty("photo.path")).listFiles()) {
            if (name.equals(file.getName())) {
                downloadFile = file;
                break;
            }
        }
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + downloadFile.getName() + "\"");
        try (FileInputStream stream = new FileInputStream(downloadFile)) {
            resp.getOutputStream().write(stream.readAllBytes());
        }
    }
}
