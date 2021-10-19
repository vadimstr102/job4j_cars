package ru.job4j.cars.controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import ru.job4j.cars.dao.BodyDao;
import ru.job4j.cars.dao.BrandDao;
import ru.job4j.cars.dao.ColorDao;
import ru.job4j.cars.dao.PostDao;
import ru.job4j.cars.model.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

public class PostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("brands", BrandDao.instOf().findAllBrands());
        req.setAttribute("colors", ColorDao.instOf().findAllColors());
        req.setAttribute("bodies", BodyDao.instOf().findAllBodies());
        req.getRequestDispatcher("/view/post.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletContext servletContext = this.getServletConfig().getServletContext();
        File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repository);
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            Brand brand = new Brand();
            String model = null;
            Body body = new Body();
            Color color = new Color();
            int year = 0;
            int price = 0;
            String description = null;
            List<Photo> photos = new ArrayList<>();
            List<FileItem> items = upload.parseRequest(req);
            Properties cfg = new Properties();
            try (
                    InputStream inputStream = getClass().getClassLoader().getResourceAsStream("photo.properties")
            ) {
                cfg.load(inputStream);
            } catch (Exception e) {
                throw new IllegalStateException(e);
            }
            File folder = new File(cfg.getProperty("photo.path"));
            if (!folder.exists()) {
                folder.mkdir();
            }
            String parameter;
            String value;
            for (FileItem item : items) {
                if (!item.isFormField() && item.getSize() != 0) {
                    photos.add(new Photo(item.getName()));
                    File file = new File(folder + File.separator + item.getName());
                    try (FileOutputStream out = new FileOutputStream(file)) {
                        out.write(item.getInputStream().readAllBytes());
                    }
                } else {
                    parameter = item.getFieldName();
                    value = item.getString("UTF-8");
                    if ("brand".equals(parameter)) {
                        brand.setId(Integer.parseInt(value));
                    } else if ("model".equals(parameter)) {
                        model = value;
                    } else if ("body".equals(parameter)) {
                        body.setId(Integer.parseInt(value));
                    } else if ("color".equals(parameter)) {
                        color.setId(Integer.parseInt(value));
                    } else if ("year".equals(parameter)) {
                        year = Integer.parseInt(value);
                    } else if ("price".equals(parameter)) {
                        price = Integer.parseInt(value);
                    } else if ("description".equals(parameter)) {
                        description = value;
                    }
                }
            }
            if (photos.isEmpty()) {
                photos.add(new Photo("no_photo.png"));
            }

            User user = (User) req.getSession().getAttribute("user");
            Car car = new Car(year, price, model, brand, color, body);
            Post post = new Post(description, new Date(), false, user, car, photos);
            PostDao.instOf().save(post);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/index");
    }
}
