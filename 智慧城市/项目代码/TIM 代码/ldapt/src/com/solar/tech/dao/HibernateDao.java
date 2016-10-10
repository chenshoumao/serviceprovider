 package com.solar.tech.dao;
 
 import java.io.Serializable;
 import java.lang.reflect.Field;
 import java.util.ArrayList;
 import java.util.Arrays;
 import java.util.Collection;
 import java.util.Iterator;
 import java.util.List;
 import org.hibernate.Criteria;
 import org.hibernate.Query;
 import org.hibernate.SQLQuery;
 import org.hibernate.ScrollableResults;
 import org.hibernate.Session;
 import org.hibernate.SessionFactory;
 import org.hibernate.Transaction;
 import org.hibernate.criterion.Criterion;
 import org.hibernate.criterion.Example;
 import org.hibernate.criterion.Order;
 import org.hibernate.criterion.Projections;
 import org.hibernate.criterion.Restrictions;
 import org.hibernate.metadata.ClassMetadata;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.orm.hibernate3.HibernateTemplate;
 import org.springframework.stereotype.Repository;


 
 @Repository
 public class HibernateDao extends HibernateTemplate implements IDao {
   @Autowired
   public void setSessionFactory(SessionFactory sessionFactory)
   {
     super.setSessionFactory(sessionFactory);
   }
 
   public Transaction beginTran() {
     return getSession().beginTransaction();
   }
 
   public void commit() {
     getSession().getTransaction()
       .commit();
   }
 
   public Serializable save(Object object)
   {
     return getSession().save(object);
   }
 
   public void save(List object)
   {
     for (int i = 0; i < object.size(); i++)
     {
       save(object.get(i));
       if (i % 50 == 0) {
         getSession().flush();
         getSession().clear();
       }
     }
   }
 
   public void save(Object[] objects) {
     save(Arrays.asList(objects));
   }
 
   public void update(Object object)
   {
     getSession().update(object);
   }
 
   public void update(List object)
   {
     for (int i = 0; i < object.size(); i++)
     {
       update(object.get(i));
       if (i % 50 == 0) {
         getSession().flush();
         getSession().clear();
       }
     }
   }
 
   public void update(Object[] objects) {
     update(Arrays.asList(objects));
   }
 
 
   public Object merge(Object obj){
     return getSession().merge(obj);
   }
 
   public Object findById(Class c, Serializable id)
   {
     Object obj = getSession().get(c, id);
     return obj;
   }
 
   public <T> List<T> findBySql(String hql,Class<T> c)
   {
     Query q = getSession().createSQLQuery(hql).addEntity(c);
     return q.list();
   }
   public  List findAll(Class c) {
     String hql = "from " + c.getSimpleName();
     return find(hql);
   }
 
   public  List findAllByOrder(Class c, String orderBy) {
     String hql = "from " + c.getSimpleName() + " order by " + orderBy;
     return find(hql);
   }
 
   public  List findPageByOrder(Class clazz, String orderBy, int page, int rows)
   {
     String hql = "from " + clazz.getSimpleName() + " order by " + orderBy;
     return findByPage(hql, page, rows);
   }
 
   public  List findExample(Object c) {
     return getSession().createCriteria(c.getClass().getName()) .add(Example.create(c)).list();
   }
 
   public List findExampleByPageFrom(Object c, int start, int limit) {
     return pageFrom(getSession()
       .createCriteria( c.getClass().getName()).add( Example.create(c)), start, limit);
   }
 
   public List findExampleByPage(Object c, int page, int rows)
   {
     return page(getSession()
       .createCriteria( c.getClass().getName()) .add( Example.create(c)), page, rows);
   }
 
   public List findByMoreField(String hql)
   {
     Query q = getSession().createQuery(hql);
     return q.list();
   }
 
   public  List findByPage(Class c, Integer page, Integer rows) {
     String queryString = "from " + c.getSimpleName();
     return findByPage(queryString, page.intValue(), rows.intValue());
   }
   public  List fuzzySearchByPage(String queryString, Integer page, Integer rows) {
	   //  String queryString = "from " + c.getSimpleName();
	     return findByPage(queryString, page.intValue(), rows.intValue());
	   }
   public  List findByPageFrom(Class c, int start, int rows)
   {
     String hql = "from " + c.getSimpleName();
     Query q = getSession().createQuery(hql);
     return pageFrom(q, start, rows);
   }
 
   private static  List pageFrom(Query query, int start, int rows) {
     query.setFirstResult(start - 1);
     query.setMaxResults(rows);
     return query.list();
   }
 
   private static  List pageFrom(Criteria criteria, int start, int rows) {
     criteria.setFirstResult(start - 1);
     criteria.setMaxResults(rows);
     return criteria.list();
   }
 
   private static  List page(Query query, int page, int rows) {
     if (page > 1)
       page = (page - 1) * rows;
     else {
       page = 0;
     }
     query.setFirstResult(page);
     query.setMaxResults(rows);
     return query.list();
   }
 
   private static  List page(Criteria criteria, int page, int rows) {
     if (page > 1)
       page = (page - 1) * rows;
     else {
       page = 0;
     }
     criteria.setFirstResult(page);
     criteria.setMaxResults(rows);
     return criteria.list();
   }
 
   public  List findByPage(String hql, int page, int rows)
   {
     Query q = getSession().createQuery(hql);
     return page(q, page, rows);
   }
 
   public Long count(String hql)
   {
     Query query = getSession().createQuery(hql);
     List list = query.list();
     if (list.size() == 0) {
       return null;
     }
     return (Long)list.get(0);
   }
 
   public  Long count(Class c)
   {
     String hql = "from " + c.getSimpleName();
     Query q = getSession().createQuery(hql);
     return Long.valueOf(getRows(q));
   }
 
   public Long count(String hql, int rowcount)
   {
     Query q = getSession().createQuery(hql);
     List list = q.list();
     if (list.size() == 0)
       return null;
     Long f = Long.valueOf(((Long)list.get(0)).longValue() % rowcount);
     if (f.longValue() == 0L) {
       return Long.valueOf(((Long)list.get(0)).longValue() / rowcount);
     }
     return Long.valueOf(((Long)list.get(0)).longValue() / rowcount + 1L);
   }
 
   public  void delete(Object objects[])
   {
       Object aobj[];
       int j = (aobj = objects).length;
       for(int i = 0; i < j; i++)
       {
           Object object = aobj[i];
           getSession().delete(object);
       }
   }
 
   public  void delete(List objects)
   {
       Object object;
       for(Iterator iterator = objects.iterator(); iterator.hasNext(); getSession().delete(object))
       {
           object = (Object)iterator.next();
       }
   }
 
   public void deleteById(Class c, Serializable id)
   {
       String hql = (new StringBuilder("delete from ")).append(c.getSimpleName()).append(" where ").append(getEntityIdName(c)).append(" = :idValue").toString();
       Query query = getSession().createQuery(hql);
       query.setParameter("idValue", id);
       query.executeUpdate();
   }
 
   public int deleteByIds(Class c, Serializable[] ids) {
     return deleteByIds(c, Arrays.asList(ids));
   }


   public int deleteByIds(Class c, List ids)
   {
       int count = 0;
       for(Iterator iterator = ids.iterator(); iterator.hasNext();)
       {
           Serializable id = (Serializable)iterator.next();
           Object entity = findById(c, id);
           if(entity != null)
           {
               delete(entity);
               count++;
           }
       }

       return count;
   }

   
   
   public void deleteByExample(Object object)
   {
       Object _obj;
       for(Iterator iterator = findExample(object).iterator(); iterator.hasNext(); delete(_obj))
       {
           _obj = (Object)iterator.next();
       }

   }
   
   
   private String getEntityIdName(Class<?> c)
   {
     return getSessionFactory().getClassMetadata(c).getIdentifierPropertyName();
   }
 
   private Serializable getEntityId(Object obj) {
     Class c = obj.getClass();
     try {
       Field idField = getClassField(c, getEntityIdName(c));
       idField.setAccessible(true);
       return (Serializable)idField.get(obj);
     } catch (Exception e) {
       throw new RuntimeException(e);
     }
   }
 
   private static Field getClassField(Class c, String fieldName)
		   throws SecurityException, NoSuchFieldException {
     Class current = c;
     
     for(current = c; current != null; current = current.getSuperclass())
     {
         List fields = Arrays.asList(current.getDeclaredFields());
         List fieldNames = new ArrayList();
         Field field;
         for(Iterator iterator = fields.iterator(); iterator.hasNext(); fieldNames.add(field.getName()))
         {
             field = (Field)iterator.next();
         }

         if(fieldNames.contains(fieldName))
         {
             return current.getDeclaredField(fieldName);
         }
     }
     return current.getDeclaredField(fieldName);
   }
 
  
   public  PageListUtil findPageByPropertysEquals(Class c, int firstResult, int maxResults, Object args[]){
   if (args.length % 2 == 1) {
       new RuntimeException("query parameter error");
     }
     List criterions = new ArrayList();
     for (int i = 0; i < args.length; i += 2) {
       criterions.add(Restrictions.eq(args[i].toString(), args[(i + 1)]));
     }
 
     return queryQBC(c, criterions, null, firstResult, maxResults);
   }
 

   public  PageListUtil findByPropertysEquals(Class c, Object args[])
   {
     if (args.length % 2 == 1) {
       new RuntimeException("query parameter error");
     }
     List criterions = new ArrayList();
     for (int i = 0; i < args.length; i += 2) {
       criterions.add(Restrictions.eq(args[i].toString(), args[(i + 1)]));
     }
     return queryQBC(c, criterions, null, 0, 1000);
   }
 

   public  PageListUtil findByPropertysLike(Class c, int firstResult, int maxResults, String args[])
   {
     if (args.length % 2 == 1) {
       new RuntimeException("query parameter error");
     }
     List criterions = new ArrayList();
     for (int i = 0; i < args.length; i += 2) {
       criterions.add(Restrictions.like(args[i], "%" + args[(i + 1)] + "%"));
     }
     return queryQBC(c, criterions, null, firstResult, firstResult);
   }
 
   public  PageListUtil findByPropertysLike(Class c, String args[])
   {
     if (args.length % 2 == 1) {
       new RuntimeException("query parameter error");
     }
     List criterions = new ArrayList();
     for (int i = 0; i < args.length; i += 2) {
       criterions.add(Restrictions.like(args[i], "%" + args[(i + 1)] + "%"));
     }
     return queryQBC(c, criterions, null, 0, 1000);
   }
 

   public  Object findSingleByProperty(Class c, Object args[])
   {
       List list = findPageByPropertysEquals(c, 0, 1, args);
       return list.size() != 0 ? list.get(0) : null;
   }
   
   public Long getRows(Criteria criteria)
   {
     Long rows = (Long)criteria.setProjection(Projections.rowCount()).list().iterator().next();
     return rows;
   }
 
   public long getRows(Query query)
   {
     ScrollableResults scrollableResults = query.scroll();
     scrollableResults.last();
     if (scrollableResults.getRowNumber() >= 0) {
       return new Long(scrollableResults.getRowNumber() + 1).longValue();
     }
     return 0L;
   }
 
   public List queryHQL(String hql) {
     return getSession().createQuery(hql).list();
   }
 
   public PageListUtil queryHQL(String hql, int firstResult, int maxResults) {
     Query query = getSession().createQuery(hql);
     long row = getRows(query);
     query.setFirstResult(firstResult);
     query.setMaxResults(maxResults);
     return new PageListUtil(row, firstResult, maxResults, query.list());
   }
 
   public  PageListUtil findPageByPropertysOrderAndEquals(Class c, Order order, int firstResult, int maxResults, Object args[])
   {
     if (args.length % 2 == 1) {
       new RuntimeException("query parameter error");
     }
     List criterions = new ArrayList();
     for (int i = 0; i < args.length; i += 2) {
       criterions.add(Restrictions.eq(args[i].toString(), args[(i + 1)]));
     }
     List orders = null;
     if (order != null) {
       orders = new ArrayList();
       orders.add(order);
     }
 
     return queryQBC(c, criterions, orders, firstResult, maxResults);
   }
 
   public PageListUtil queryQBC(Class c, List criterions, List orders, int firstResult, int maxResults)
   {
     Criteria criteria = getSession().createCriteria(c);
     if (criterions != null) {
         Criterion criterion;
         for(Iterator iterator = criterions.iterator(); iterator.hasNext(); criteria.add(criterion))
         {
             criterion = (Criterion)iterator.next();
         }
     }
 
     if (orders != null) {
         Order order;
         for(Iterator iterator1 = orders.iterator(); iterator1.hasNext(); criteria.addOrder(order))
         {
             order = (Order)iterator1.next();
         }
     }
     else if (hasField(c, "created")) {
       criteria.addOrder(Order.desc("created"));
     }
 
     criteria.setFirstResult(firstResult);
     criteria.setMaxResults(maxResults);
     List list = criteria.list();
 
     return new PageListUtil(0L, firstResult, maxResults, list);
   }
 
   public static boolean hasField(Class c, String fieldName)
   {
     Field[] fields = c.getDeclaredFields();
     for (Field field : fields) {
       if (field.getName().equals(fieldName)) {
         return true;
       }
     }
     return false;
   }
 
   public void saveOrUpdate(Object object)
   {
     getSession().saveOrUpdate(object);
   }
 
   public CloneableI clone(CloneableI object)
   {
       CloneableI clone;
       try
       {
           clone = (CloneableI)object.cloneI();
       }
       catch(CloneNotSupportedException e)
       {
           throw new RuntimeException(e);
       }
       return clone;
   }
 
   public int executeJDBCSql(String sql)
   {
     return getSession().createSQLQuery(sql).executeUpdate();
   }
 
   public List executeJDBCSqlQuery(String sql) {
     return getSession().createSQLQuery(sql).list(); } 
   public static interface CloneableI
   extends Cloneable
{

   public abstract Object cloneI()
       throws CloneNotSupportedException;
}
   public static class PageListUtil extends ArrayList { 
	   private int pageCount = 20;
 
     private int position = 0;
     private long totalCount;
 
     protected static int getStartOfPage(int pageNo) { return getStartOfPage(pageNo, 20); }
 
     public static int getStartOfPage(int pageNo, int pageSize) {
       return (pageNo - 1) * pageSize;
     }
 
     public PageListUtil()
     {
     }
 
     public PageListUtil(Collection c)
     {
         super(c);
         pageCount = 20;
         position = 0;
     }

     public PageListUtil(int initialCapacity)
     {
         super(initialCapacity);
         pageCount = 20;
         position = 0;
     }
 
     public PageListUtil(long totalSize, int position, int pageCount, Collection data)
     {
         super(data);
         this.pageCount = 20;
         this.position = 0;
         totalCount = totalSize;
         this.pageCount = pageCount;
         this.position = position;
     }
 
     public int getCurrentPage()
     {
       return this.position / this.pageCount + 1;
     }
 
     public int getPageSize() {
       return this.pageCount;
     }
 
     public long getTotalCount() {
       return this.totalCount;
     }
 
     public int getTotalPage() {
       if (this.totalCount % this.pageCount == 0L) {
         return (int)(this.totalCount / this.pageCount);
       }
       return (int)(this.totalCount / this.pageCount + 1L);
     }
 
     public boolean hasNextPage() {
       return getCurrentPage() < getTotalPage() - 1;
     }
 
     public boolean hasPreviousPage() {
       return getCurrentPage() > 1;
     }
   }
 }

