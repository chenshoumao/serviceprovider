package com.solar.tech.dao;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GenericDao{
	
	@Autowired
	private SessionFactory sessionFactory;
	
//	private static GenericDao dao=null;
//	private static Configuration config=null;
	
//	public Configuration getConfig(){
//		return config;
//	}
	
	/*@SuppressWarnings("serial")
	private GenericDao(){
		try {
			if(sessionFactory==null){
				config = new Configuration().configure();
				config.setInterceptor(new EmptyInterceptor(){
					@Override
					public boolean onSave(Object entity, Serializable id,
							Object[] state, String[] propertyNames, Type[] types)
							throws CallbackException {
						for(int i=0; i<propertyNames.length; i++){
							if(Current.CREATED.equals(propertyNames[i])){
								state[i]=Current.time();
							}else if(Current.CREATEDBY.equals(propertyNames[i])){
								state[i]=Current.user();
							}else if(Current.MODIFIED.equals(propertyNames[i])){
								state[i]=Current.time();
							}else if(Current.UPDATEBY.equals(propertyNames[i])){
								state[i]=Current.user();
							}
						}
						return false;
					}
					
					@Override
					public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, 
							Object[] previousState, String[] propertyNames, Type[] types) {
						for(int i=0; i<propertyNames.length; i++){
							if(Current.CREATED.equals(propertyNames[i])){
								if(previousState!=null) currentState[i]=previousState[i];
							}else if(Current.CREATEDBY.equals(propertyNames[i])){
								if(previousState!=null) currentState[i]=previousState[i];
							}else if(Current.MODIFIED.equals(propertyNames[i])){
								currentState[i]=Current.time();
							}else if(Current.UPDATEBY.equals(propertyNames[i])){
								currentState[i]=Current.user();
							}
						}
						return false;
					}
				});
				sessionFactory = config.buildSessionFactory();
			}
		} catch (Exception e) {
			System.err.println("Initial SessionFactory creation failed." + e);
			throw new ExceptionInInitializerError(e);
		}
	}*/
	
	/*public static GenericDao get(){
		if(dao==null){
			dao=new GenericDao();
		}
		return dao;
	}*/
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Transaction beginTran(){
		return getSession().beginTransaction();
	}
	
	public void commit(){
		getSession().getTransaction()
					.commit();
	}
	
	/**
	 * 娣诲姞
	 * 
	 * @param object
	 *            瑕佹坊鍔犵殑瀵硅薄
	 * @return 
	 */
	public Serializable save(Object object) {
		return getSession().save(object);
	}

	/**
	 * 鎵归噺娣诲姞
	 * 
	 * @param object
	 *            瑕佹坊鍔犲璞�
	 */
	public void save(List<?> object) {
		for (int i = 0; i < object.size(); i++) {
			//getSession().save(object.get(i));
			save(object.get(i));
			if (i % 50 == 0) {
				getSession().flush();
				getSession().clear();
			}
		}
	}
	
	public void save(Object... objects) {
		save(Arrays.asList(objects));
	}

	/**
	 * 鏇存柊鏁版嵁
	 * 
	 * @param object
	 *            瑕佹洿鏂扮殑瀵硅薄
	 */
	public void update(Object object) {
		getSession().update(object);
	}

	/**
	 * 鎵归噺鏇存柊
	 * 
	 * @param object
	 *            鏇存柊鐨勫璞�
	 */
	public void update(List<?> object) {
		for (int i = 0; i < object.size(); i++) {
			//getSession().update(object.get(i));
			update(object.get(i));
			if (i % 50 == 0) {
				getSession().flush();
				getSession().clear();
			}
		}
	}
	
	public void update (Object... objects){
		update(Arrays.asList(objects));
	}
	
	public<T> T merge(T obj){
		return (T) getSession().merge(obj);
	}

	/**
	 * 鏍规嵁id 鏌ヨ
	 * 
	 * @param c
	 *            瑕佹煡璇㈢殑瀵硅薄 Class
	 * @param id
	 *            瑕佹煡璇㈢殑id
	 * @return Object
	 */
	public <T> T findById(Class<T> c, Serializable id) {
		T obj= (T)getSession().get(c, id);
		return obj;
	}

	/**
	 * 鏌ヨ
	 * 
	 * @param hql
	 *            瑕佹煡璇㈢殑sql璇彞
	 * @return List<?>
	 */
	public <T> List<T> find(String hql) {
		Query q = getSession().createQuery(hql);
		return q.list();
	}
	public <T> List<T> findBySql(String hql,Class<T> c) {
		//Query q = getSession().createQuery(hql);
		Query q = getSession().createSQLQuery(hql).addEntity(c);
		return q.list();
	}
	public <T> List<T> findAll(Class<T> c) {
		String hql = "from " + c.getSimpleName();
		return find(hql);
	}
	
	public <T> List<T> findAllByOrder(Class<T> c, String orderBy){
		String hql = "from " + c.getSimpleName()+" order by "+orderBy;
		return find(hql);
	}
	
	/**
	 * 閫氳繃瀹炰綋绫诲睘鎬ф帓搴忓垎椤垫煡鎵�
	 * @param clazz 瑕佹煡鎵剧殑瀹炰綋绫�
	 * @param orderBy 瑕佹帓搴忕殑瀹炰綋绫诲睘鎬э紝閫楀彿鍒嗛殧澶氫釜灞炴�
	 * @param page 瑕佹煡鐨勯〉鏁�
	 * @param rows 椤电殑澶у皬
	 * @return
	 */
	public <T> List<T> findPageByOrder(Class<T> clazz, String orderBy, int page, int rows){
		String hql = "from " + clazz.getSimpleName()+" order by "+orderBy;
		return findByPage(hql, page, rows);
	}
	
	public <T> List<T> findExample(T c){
		return getSession().createCriteria(c.getClass().getName())
				.add(Example.create(c)).list();
	}
	
	public <T> List<T> findExampleByPageFrom(T c, int start, int limit){
		return pageFrom(getSession()
							.createCriteria(
									c
									.getClass()
									.getName())
										.add(Example
												.create(c)), start, limit);
		
	}
	
	public <T> List<T> findExampleByPage(T c, int page, int rows){
		return page(getSession()
						.createCriteria(
								c
								.getClass()
									.getName())
										.add(Example
												.create(c)), page, rows);
		
	}

	/**
	 * 鏌ヨ
	 * 
	 * @param hql
	 *            瑕佹煡璇㈢殑sql璇彞
	 * @return List<Object[]>
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> findByMoreField(String hql) {
		Query q = getSession().createQuery(hql);
		return q.list();
	}
	
	public <T> List<T> findByPage(Class<T> c, Integer page, Integer rows){
		String queryString = "from " + c.getSimpleName();
		return findByPage(queryString, page, rows);
	}
	

	
	public <T> List<T> findByPageFrom(Class<T> c, int start, int rows) {
		String hql = "from " + c.getSimpleName();
		Query q = getSession().createQuery(hql);
		return pageFrom(q, start, rows);
	}
	
	private static<T> List<T> pageFrom(Query query, int start, int rows){
		query.setFirstResult(start-1);
		query.setMaxResults(rows);
		return query.list();
	}
	
	private static<T> List<T> pageFrom(Criteria criteria, int start, int rows){
		criteria.setFirstResult(start-1);
		criteria.setMaxResults(rows);
		return criteria.list();
	}
	
	private static<T> List<T> page(Query query, int page, int rows){
		if (page > 1) {
			page = (page - 1) * rows;
		} else {
			page = 0;
		}
		query.setFirstResult(page);
		query.setMaxResults(rows);
		return query.list();
	}
	
	private static<T> List<T> page(Criteria criteria, int page, int rows){
		if (page > 1) {
			page = (page - 1) * rows;
		} else {
			page = 0;
		}
		criteria.setFirstResult(page);
		criteria.setMaxResults(rows);
		return criteria.list();
	}

	/**
	 * 鍒嗛〉鏌ユ壘
	 * 
	 * @param hql
	 *            sql 璇彞
	 * @param page
	 *            椤垫暟
	 * @param rows
	 *            鏉℃暟
	 * @return List<?>
	 */
	public <T> List<T> findByPage(String hql, int page, int rows) {
		Query q = getSession().createQuery(hql);
		return page(q, page, rows);
	}

	/**
	 * 璁＄畻鏈夊灏戞潯鏁版嵁
	 * 
	 * @param hql
	 *            sql璇彞
	 * @return Long
	 */
	public Long count(String hql) {
		Query query = getSession().createQuery(hql);
		List<Long> list = query.list();
		if (list.size() == 0) {
			return null;
		} else {
			return list.get(0);
		}
	}
	
	public <T> Long count(Class<T> c) {
		String hql = "from " + c.getSimpleName();
		Query q = getSession().createQuery(hql);
		return getRows(q);
	}

	/**
	 * 鑾峰彇鏈夊灏戦〉鏁�
	 * 
	 * @param hql
	 *            sql 璇彞
	 * @param rowcount
	 *            涓�〉鏈夊灏戞潯鏁版嵁
	 * @return Long
	 */
	public Long count(String hql, int rowcount) {
		Query q = getSession().createQuery(hql);
		List<Long> list = q.list();
		if (list.size() == 0)
			return null;
		Long f = list.get(0) % rowcount;
		if (f == 0) {
			return list.get(0) / rowcount;
		} else {
			return list.get(0) / rowcount + 1;
		}

	}

	/**
	 * 鍒犻櫎
	 * 
	 * @param object
	 *            瑕佸垹闄ょ殑瀵硅薄
	 */
	public <T> void delete(T... objects) {
		for(T object: objects){
			getSession().delete(object);
		}
	}
	
	public <T> void delete(List<T> objects) {
		for(T object: objects){
			getSession().delete(object);
		}
	}
	
	public void deleteById(Class<?> c, Serializable id){
		String hql = "delete from "+c.getSimpleName()+" where "+getEntityIdName(c)+" = :idValue";
	    Query query = getSession().createQuery(hql);
	    query.setParameter("idValue", id);
	    query.executeUpdate();
	}
	
	public int deleteByIds(Class<?> c, Serializable...ids){
		return deleteByIds(c, Arrays.asList(ids));
	}
	
	public int deleteByIds(Class<?> c, List<Serializable> ids){
		int count=0;
		for(Serializable id: ids){
			Object entity=this.findById(c, id);
			if(entity!=null){
				this.delete(entity);
				count++;
			}
		}
		return count;
	}
	
	public <T> void deleteByExample(T object) {
		for(T _obj: findExample(object)){
			delete(_obj);
		}
	}
	
	private String getEntityIdName(Class<?> c){
		return getSessionFactory().getClassMetadata(c).getIdentifierPropertyName();
	}
	
	private Serializable getEntityId(Object obj){
		Class<?> c=obj.getClass();
		try {
			Field idField=getClassField(c, getEntityIdName(c));
			idField.setAccessible(true);
			return (Serializable)idField.get(obj);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	private static Field getClassField(Class<?> c, String fieldName) throws SecurityException, NoSuchFieldException{
		Class<?> current=c;
		while(current!=null){
			List<Field> fields=Arrays.asList(current.getDeclaredFields());
			List<String> fieldNames=new ArrayList<String>();
			for(Field field: fields){
				fieldNames.add(field.getName());
			}
			if(fieldNames.contains(fieldName))
				return current.getDeclaredField(fieldName);
			else
				current=current.getSuperclass();
		}
		return current.getDeclaredField(fieldName);
	}
	
	public <T> PageListUtil<T> findPageByPropertysEquals(Class<T> c, int firstResult, int maxResults, Object... args) {
		if (args.length % 2 == 1) {
			new RuntimeException("query parameter error");
		}
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (int i = 0; i < args.length; i = i + 2) {
			criterions.add(Restrictions.eq(args[i].toString(), args[i + 1]));
		}
		return queryQBC(c, criterions, null, firstResult, maxResults);
	}

	
	public PageListUtil<?> findByPropertysEquals(Class<?> c, Object... args) {
		if (args.length % 2 == 1) {
			new RuntimeException("query parameter error");
		}
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (int i = 0; i < args.length; i = i + 2) {
			criterions.add(Restrictions.eq(args[i].toString(), args[i + 1]));
		}
		return queryQBC(c, criterions, null, 0, 1000);
	}

	
	public PageListUtil<?> findByPropertysLike(Class<?> c, int firstResult, int maxResults, String... args) {
		if (args.length % 2 == 1) {
			new RuntimeException("query parameter error");
		}
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (int i = 0; i < args.length; i = i + 2) {
			criterions.add(Restrictions.like(args[i], "%" + args[i + 1] + "%"));
		}
		return queryQBC(c, criterions, null, firstResult, firstResult);
	}

	
	public PageListUtil<?> findByPropertysLike(Class<?> c, String... args) {
		if (args.length % 2 == 1) {
			new RuntimeException("query parameter error");
		}
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (int i = 0; i < args.length; i = i + 2) {
			criterions.add(Restrictions.like(args[i], "%" + args[i + 1] + "%"));
		}
		return queryQBC(c, criterions, null, 0, 1000);
	}

	
	public <T> T findSingleByProperty(Class<T> c, Object... args) {
		List<T> list = findPageByPropertysEquals(c, 0, 1, args);
		return (list.size() == 0) ? null : list.get(0);
	}

	
	public Long getRows(Criteria criteria) {
		Long rows = (Long) criteria.setProjection(Projections.rowCount()).list().iterator().next();
		return rows;
	}

	
	public long getRows(Query query) {
		ScrollableResults scrollableResults = query.scroll();
		scrollableResults.last();
		if (scrollableResults.getRowNumber() >= 0) {
			return new Long(scrollableResults.getRowNumber() + 1);
		}
		return 0;
	}

	public <T> List<T> queryHQL(String hql) {
		return getSession().createQuery(hql).list();
	}
	
	public <T> PageListUtil<T> queryHQL(String hql, int firstResult, int maxResults) {
		Query query = getSession().createQuery(hql);
		long row = getRows(query);
		query.setFirstResult(firstResult);
		query.setMaxResults(maxResults);
		return new PageListUtil<T>(row, firstResult, maxResults, query.list());
	}

	
	public PageListUtil<?> findPageByPropertysOrderAndEquals(Class<?> c, Order order, int firstResult, int maxResults, Object... args) {
		if (args.length % 2 == 1) {
			new RuntimeException("query parameter error");
		}
		List<Criterion> criterions = new ArrayList<Criterion>();
		for (int i = 0; i < args.length; i = i + 2) {
			criterions.add(Restrictions.eq(args[i].toString(), args[i + 1]));
		}
		List<Order> orders = null;
		if (order != null) {
			orders = new ArrayList<Order>();
			orders.add(order);
		}

		return queryQBC(c, criterions, orders, firstResult, maxResults);
	}

	
	public <T> PageListUtil<T> queryQBC(Class<T> c, List<Criterion> criterions, List<Order> orders, int firstResult, int maxResults) {
		Criteria criteria = getSession().createCriteria(c);
		if (criterions != null) {
			for (Criterion criterion : criterions) {
				criteria.add(criterion);
			}
		}
		//Long row = getRows(criteria);
		if (orders != null) {
			for (Order order : orders) {
				criteria.addOrder(order);
			}
		} else if (hasField(c, "created")) {
			criteria.addOrder(Order.desc("created"));
		}
		// Criterion criterion=Restrictions.like("name", "T%");
		
		criteria.setFirstResult(firstResult);
		criteria.setMaxResults(maxResults);
		List<T> list = criteria.list();

		return new PageListUtil<T>(0, firstResult, maxResults, list);
	}

	/**
	 * 鍒ゆ柇绫绘槸鍚︽湁鏌愪釜灞炴�
	 * @param c
	 * @param fieldName
	 * @return
	 */
	public static boolean hasField(Class<?> c, String fieldName) {
		Field[] fields = c.getDeclaredFields();
		for (Field field : fields) {
			if (field.getName().equals(fieldName)) {
				return true;
			}
		}
		return false;
	}

	
	public void saveOrUpdate(Object object) {
		getSession().saveOrUpdate(object);
	}
	
	public <T extends CloneableI<T>> T clone(T object){
		T clone;
		try {
			clone = object.cloneI();
		} catch (CloneNotSupportedException e) {
			throw new RuntimeException(e);
		}
		return clone;
	}
	
	//add by weijun xiao
	public int executeJDBCSql(String sql){
		return getSession().createSQLQuery(sql).executeUpdate();
	}
	
	public List executeJDBCSqlQuery(String sql){
		return getSession().createSQLQuery(sql).list();
	}
	
	
	@SuppressWarnings("serial")
	public static class PageListUtil<T> extends ArrayList<T>{
		protected static int getStartOfPage(int pageNo) {
			return getStartOfPage(pageNo, 20);
		}
		public static int getStartOfPage(int pageNo, int pageSize) {
			return (pageNo - 1) * pageSize;
		}
		private int pageCount = 20;

		private int position = 0;

		private long totalCount;

		public PageListUtil() {
			super();
		}

		public PageListUtil(Collection<? extends T> c) {
			super(c);
		}

		public PageListUtil(int initialCapacity) {
			super(initialCapacity);
		}

		public PageListUtil(long totalSize, int position, int pageCount, Collection<? extends T> data) {
			super(data);
			this.totalCount = totalSize;
			this.pageCount = pageCount;
			this.position = position;

		}

		public int getCurrentPage() {
			return position / pageCount + 1;
		}

		public int getPageSize() {
			return pageCount;
		}

		public long getTotalCount() {
			return this.totalCount;
		}

		public int getTotalPage() {
			if (totalCount % pageCount == 0)
				return (int) (totalCount / pageCount);
			else
				return (int) (totalCount / pageCount + 1);
		}

		public boolean hasNextPage() {
			return this.getCurrentPage() < this.getTotalPage() - 1;
		}

		public boolean hasPreviousPage() {
			return this.getCurrentPage() > 1;
		}
	}
	
	public interface CloneableI<T> extends Cloneable{
		public T cloneI() throws CloneNotSupportedException;
	}
}
