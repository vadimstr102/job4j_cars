package ru.job4j.cars.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.cars.model.User;

import java.util.function.Function;

public class UserDao implements AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final UserDao INST = new UserDao();
    }

    public static UserDao instOf() {
        return UserDao.Lazy.INST;
    }

    public void save(User user) {
        transaction(session -> session.save(user));
    }

    public User findUserByEmail(String email) {
        return transaction(session -> session.createQuery("from User u where u.email = :fEmail", User.class)
                .setParameter("fEmail", email)
                .uniqueResult()
        );
    }

    private <T> T transaction(final Function<Session, T> command) {
        try (Session session = sf.openSession()) {
            final Transaction tx = session.beginTransaction();
            try {
                T rsl = command.apply(session);
                tx.commit();
                return rsl;
            } catch (final Exception e) {
                session.getTransaction().rollback();
                throw e;
            }
        }
    }

    @Override
    public void close() {
        StandardServiceRegistryBuilder.destroy(registry);
    }
}
