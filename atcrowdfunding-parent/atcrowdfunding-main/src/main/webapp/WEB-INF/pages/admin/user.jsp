<%--
  Created by IntelliJ IDEA.
  User: Miluo
  Date: 2020/9/14
  Time: 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%@include file="/WEB-INF/pages/include/base_css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <%@include file="/WEB-INF/pages/include/manager_loginbar.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">

            <%@include file="/WEB-INF/pages/include/manager_menu.jsp"%>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;" action="${pageContext.request.contextPath}/admin/index">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input value="${param.condition}" name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger batchDeleteBtn" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${pageContext.request.contextPath}/admin/edit.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${!empty pageInfo.list}">
                                <c:forEach items="${pageInfo.list}" var="item" varStatus="vs">
                                    <tr>
                                        <td>${vs.count}</td>
                                        <td><input type="checkbox" adminid="${item.id}"></td>
                                        <td>${item.loginacct}</td>
                                        <td>${item.username}</td>
                                        <td>${item.email}</td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                            <button type="button" onclick="window.location='${pageContext.request.contextPath}/admin/edit.html?id=${item.id}'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                            <button type="button"  adminid="${item.id}"  class="btn btn-danger btn-xs deleteAdminBtn"><i class=" glyphicon glyphicon-remove"></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>

                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:choose>
                                            <c:when test="${pageInfo.isFirstPage}">
                                                <%-- 当前页是第一页，上一页禁用--%>
                                                <li class="disabled"><a href="javascript:void(0)">上一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <%-- 不是第一页，上一页可以点击--%>
                                                <li><a href="${pageContext.request.contextPath}/admin/index?pageNum=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                        <%-- 中间页码 --%>
                                        <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                                            <c:choose>
                                                <c:when test="${index==pageInfo.pageNum}">
                                                    <%-- 正在显示当前页，高亮显示禁止点击 --%>
                                                    <li class="active"><a href="javascript:void(0)">${index} <span class="sr-only">(current)</span></a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li><a href="${pageContext.request.contextPath}/admin/index?pageNum=${index}&condition=${param.condition}">${index}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <%-- 下一页 --%>
                                        <c:choose>
                                            <c:when test="${pageInfo.isLastPage}">
                                                <%-- 当前页是最后一页，下一页禁用--%>
                                                <li class="disabled"><a href="javascript:void(0)">下一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <%-- 不是最后一页，下一页可以点击--%>
                                                <li><a href="${pageContext.request.contextPath}/admin/index?pageNum=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/pages/include/base_js.jsp"%>
<script type="text/javascript">

    //当前页面所在模块的菜单自动展开+模块标签高亮显示
    $(".list-group-item:contains(' 权限管理 ')").removeClass("tree-closed");
    $(".list-group-item:contains(' 权限管理 ') ul").show();
    $(".list-group-item:contains(' 权限管理 ') li :contains('用户维护')").css("color","red");

    //用户全选框设置
    $("table thead :checkbox").click(function () {
       $("table tbody :checkbox").prop("checked",this.checked)
    });

    $("table tbody :checkbox").click(function () {
        var loginacctCount = $("table tbody :checkbox").length;
        var checkedCount = $("table tbody :checkbox:checked").length;
        $("table thead :checkbox").prop("checked",loginacctCount == checkedCount);
    });



    //批量删除
    $(".batchDeleteBtn").click(function () {
        var checkedIpu = $("table tbody :checkbox:checked");
        var idsArr = new Array();
        checkedIpu.each(function () {
            idsArr.push($(this).attr("adminid"));
        });
        if (idsArr.length == 0){
            layer.msg("请选择要删除的管理员");
            return;
        }
        layer.confirm("确定要删除吗？",function () {
            window.location="${pageContext.request.contextPath}/admin/batchDelete?ids=" + idsArr.join();
        })

    });



    //删除用户
    $(function () {
        $(".deleteAdminBtn").click(function () {
           var adminid = $(this).attr("adminid");
           var name = $(this).parents("tr").children("td:eq(2)").text();
           layer.confirm("你要删除"+name +"吗？",function () {
               window.location="${pageContext.request.contextPath}/admin/delete/"+adminid;
           })
        });


        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

</script>
</body>
</html>

