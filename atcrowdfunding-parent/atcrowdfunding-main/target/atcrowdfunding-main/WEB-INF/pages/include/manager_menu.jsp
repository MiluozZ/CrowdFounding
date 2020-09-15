<%--
  Created by IntelliJ IDEA.
  User: Miluo
  Date: 2020/9/13
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">

        <c:forEach items="${pmenus}" var="pmenu">

            <c:choose>
                <c:when test="${empty pmenu.children}">

                    <li class="list-group-item tree-closed" >
                        <a href="${pageContext.request.contextPath}/${pmenu.url}"><i class="${pmenu.icon}"></i> ${pmenu.name}</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="list-group-item tree-closed">
                        <span><i class="${pmenu.icon}"></i> ${pmenu.name} <span class="badge" style="float:right">${pmenu.children.size()}</span></span>
                        <ul style="margin-top:10px;display:none;">

                            <c:forEach items="${pmenu.children}" var="menu">
                                <li style="height:30px;">
                                    <a href="${pageContext.request.contextPath}/${menu.url}"><i class="${menu.icon}"></i> ${menu.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

    </ul>
</div>


    </ul>
</div>