package ru.job4j.cars.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.cars.model.Post;

import java.util.List;
import java.util.function.Function;

public class PostDao implements AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final PostDao INST = new PostDao();
    }

    public static PostDao instOf() {
        return PostDao.Lazy.INST;
    }

    public void save(Post post) {
        transaction(session -> session.save(post));
    }

    public List<Post> findAllPosts() {
        return transaction(
                session -> session.createQuery(
                        "select distinct p from Post p left outer join fetch p.photos order by p.isSold, p.created desc", Post.class
                ).list()
        );
    }

    public void updatePostAsSold(int id) {
        transaction(
                session -> {
                    session.get(Post.class, id).setIsSold(true);
                    return true;
                }
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
