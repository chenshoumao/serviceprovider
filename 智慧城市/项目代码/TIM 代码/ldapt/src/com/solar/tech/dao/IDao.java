package com.solar.tech.dao;

import java.io.Serializable;
import java.util.List;

public abstract interface IDao
{
    public abstract List findAll(Class class1);
    
    public  List fuzzySearchByPage(String queryString, Integer page, Integer rows);
    
    public <T> List<T> findBySql(String hql,Class<T> c);

    public <T> List<T> findExample(T c);

    public abstract void saveOrUpdate(Object obj);
    
    public <T> List<T> find(String hql);

    public <T> List<T> findByPage(Class<T> c, Integer page, Integer rows);
    public <T> List<T> findByPage(String hql, int page, int rows);

    public abstract Long count(Class class1);

    public abstract void update(Object obj);

    public abstract Serializable save(Object obj);

    public <T> T findById(Class<T> c, Serializable id);

    public abstract void deleteByExample(Object obj);

    public  abstract void delete(Object aobj[]);

    public <T> void delete(List<T> objects);
}

