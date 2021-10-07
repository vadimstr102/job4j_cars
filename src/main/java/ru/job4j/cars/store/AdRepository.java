package ru.job4j.cars.store;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.cars.model.Post;

import java.util.Date;
import java.util.List;
import java.util.function.Function;

public class AdRepository implements AutoCloseable {
    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();
    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();

    private static final class Lazy {
        private static final AdRepository INST = new AdRepository();
    }

    public static AdRepository instOf() {
        return Lazy.INST;
    }

    public List<Post> getPostsForTheLastDay() {
        long oneDayInMillis = 24 * 60 * 60 * 1000;
        Date oneDayAgo = new Date(System.currentTimeMillis() - oneDayInMillis);
        return transaction(
                session -> session.createQuery("from Post where created >= :fDate", Post.class)
                        .setParameter("fDate", oneDayAgo)
                        .list()
        );
    }

    public List<Post> getPostsWithPhoto() {
        return transaction(
                session -> session.createQuery("select distinct p from Post p join fetch p.photos", Post.class)
                        .list()
        );
    }

    public List<Post> getPostsByBrand(String brand) {
        return transaction(
                session -> session.createQuery(
                                "select distinct p from Post p join fetch p.car c where c.brand = :fBrand", Post.class
                        )
                        .setParameter("fBrand", brand)
                        .list()
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

    public static void main(String[] args) {
        AdRepository.instOf().getPostsForTheLastDay().forEach(System.out::println);
        AdRepository.instOf().getPostsWithPhoto().forEach(System.out::println);
        AdRepository.instOf().getPostsByBrand("bmw").forEach(System.out::println);
    }
}
