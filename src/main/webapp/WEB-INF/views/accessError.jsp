<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/top.jsp"%>

<h1>Access Denied</h1>

<h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>

<h2><c:out value="${msg}"/></h2>

<%@ include file="/WEB-INF/views/foot.jsp"%>