package com.valencia.itemlistwebapp;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.ItemsEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

@WebServlet("/items")
public class ItemsController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;

    @Override
    public void init() throws ServletException {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                req.getRequestDispatcher("/items.jsp").forward(req, resp);
                break;
            case "delete":
                deleteItem(req, resp);
                break;
            case "list":
                listItems(req, resp);
                break;
            case "4":
                resp.sendRedirect(req.getContextPath() + "/");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/items?action=list");
                break;
        }
    }

    private void deleteItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            ItemsEntity itemsEntity = entityManager.find(ItemsEntity.class, id);
            if (itemsEntity != null) {
                entityManager.remove(itemsEntity);
                transaction.commit();
            } else {
                transaction.rollback();
                System.out.println("Item not found.");
            }
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        resp.sendRedirect(req.getContextPath() + "/items?action=list");
    }

    private void listItems(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        TypedQuery<ItemsEntity> query = entityManager.createQuery("SELECT i FROM ItemsEntity i", ItemsEntity.class);
        List<ItemsEntity> items = query.getResultList();
        req.setAttribute("items", items);
        req.getRequestDispatcher("/items.jsp").forward(req, resp);
        entityManager.close();
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("1".equals(action)) {
            String item = req.getParameter("item");
            EntityManager entityManager = entityManagerFactory.createEntityManager();
            EntityTransaction transaction = entityManager.getTransaction();

            try {
                transaction.begin();
                ItemsEntity itemsEntity = new ItemsEntity();
                itemsEntity.setItem(item);
                entityManager.persist(itemsEntity);
                transaction.commit();
            } catch (Exception e) {
                transaction.rollback();
                e.printStackTrace();
            } finally {
                entityManager.close();
            }
        }

        else if("2".equals(action))
        {
            resp.sendRedirect(req.getContextPath() + "/items?action=delete&id=" + req.getParameter("id"));
            return;
        }
        else if("4".equals(action))
        {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/items?action=list");
    }
}

