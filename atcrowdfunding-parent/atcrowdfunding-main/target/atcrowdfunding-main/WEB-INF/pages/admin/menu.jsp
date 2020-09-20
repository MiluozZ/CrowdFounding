<%--
  Created by IntelliJ IDEA.
  User: Miluo
  Date: 2020/9/19
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/pages/include/base_css.jsp"%>
    <link rel="stylesheet" href="ztree/zTreeStyle.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>




                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<%@include file="/WEB-INF/pages/include/base_js.jsp"%>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    //zTree设置
        //zTree的参数设置
    var setting = {};

        //zTree的数据属性设置
    var zNodes =[
        { name:"父节点1 - 展开", open:true,
            children: [
                { name:"父节点11 - 折叠",
                    children: [
                        { name:"叶子节点111"},
                        { name:"叶子节点112"},
                        { name:"叶子节点113"},
                        { name:"叶子节点114"}
                    ]},
                { name:"父节点12 - 折叠",
                    children: [
                        { name:"叶子节点121"},
                        { name:"叶子节点122"},
                        { name:"叶子节点123"},
                        { name:"叶子节点124"}
                    ]},
                { name:"父节点13 - 没有子节点", isParent:true}
            ]},
        { name:"父节点2 - 折叠",
            children: [
                { name:"父节点21 - 展开", open:true,
                    children: [
                        { name:"叶子节点211"},
                        { name:"叶子节点212"},
                        { name:"叶子节点213"},
                        { name:"叶子节点214"}
                    ]},
                { name:"父节点22 - 折叠",
                    children: [
                        { name:"叶子节点221"},
                        { name:"叶子节点222"},
                        { name:"叶子节点223"},
                        { name:"叶子节点224"}
                    ]},
                { name:"父节点23 - 折叠",
                    children: [
                        { name:"叶子节点231"},
                        { name:"叶子节点232"},
                        { name:"叶子节点233"},
                        { name:"叶子节点234"}
                    ]}
            ]},
        { name:"父节点3 - 没有子节点", isParent:true}

    ];

        //zTree的初始化
    $.fn.zTree.init($("#treeDemo"), setting, zNodes);


    //异步查询菜单列表
    $.ajax({
        type:"get",
        url:"${pageContext.request.contextPath}/menu/getMenus",
        success:function (menus) {
            console.log(menus);

            menus.push({"id":0,"name":"系统权限菜单"});

            //zTree设置
            //zTree的参数设置
            var setting = {
                view: {
                    addDiyDom: function (treeId ,treeNode) {
                        //console.log(treeNode);
                        $("#"+treeNode.tId + "_ico").remove();
                        $("#"+treeNode.tId + "_span").before("<span class='"+treeNode.icon+"'></span>");
                    }
                },
                data: {
                    simpleData: {
                        enable: true,
                        pIdKey: "pid"
                    }
                }
            };

            //zTree的数据属性设置
            var zNodes = menus;

            //zTree的初始化
            var $ztreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);

            $ztreeObj.expandAll(true);
        }
    });




    //菜单导航高亮显示
    $(".list-group-item:contains(' 权限管理 ')").removeClass("tree-closed");
    $(".list-group-item:contains(' 权限管理 ') ul").show();
    $(".list-group-item:contains(' 权限管理 ') li :contains('菜单维护')").css("color","red");


    $(function () {
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

