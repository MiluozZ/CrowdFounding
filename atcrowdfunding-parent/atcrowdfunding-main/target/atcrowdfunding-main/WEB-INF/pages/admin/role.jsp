<%--
  Created by IntelliJ IDEA.
  User: Miluo
  Date: 2020/9/15
  Time: 11:53
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryRolesBtn" type="button" class="btn btn-warning "><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="batchDelete" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="showInsertRoleBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input id="selectAll" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <%--<li class="disabled"><a href="#">上一页</a></li>--%>
                                        <%--<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>--%>
                                        <%--<li><a href="#">2</a></li>--%>
                                        <%--<li><a href="#">3</a></li>--%>
                                        <%--<li><a href="#">4</a></li>--%>
                                        <%--<li><a href="#">5</a></li>--%>
                                        <%--<li><a href="#">下一页</a></li>--%>
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


//新增用户模态框
<div class="modal fade" id="insertRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称</label>
                        <input type="text" name="name" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="insertRole" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/pages/include/base_js.jsp"%>
<script type="text/javascript">
    var currentPagenum;
    var totalPages;


    //菜单导航高亮显示
    $(".list-group-item:contains(' 权限管理 ')").removeClass("tree-closed");
    $(".list-group-item:contains(' 权限管理 ') ul").show();
    $(".list-group-item:contains(' 权限管理 ') li :contains('角色维护')").css("color","red");



    //---------------------批量删除-------------------------------
    //全选单选关联
    $("thead :checkbox").click(function () {
       $("tbody :checkbox").prop("checked",this.checked);
    });
    $("tbody").delegate(":checkbox","click",function () {
        $("thead :checkbox").prop("checked",$("tbody :checkbox").length == $("tbody :checked:checked").length)
    });



    $("#batchDelete").click(function () {
       var roleDelArr = new Array();
       $("tbody :checkbox:checked").each(function () {
           roleDelArr.push($(this).attr("roleid"));
       });

       if (roleDelArr.length == 0){
           layer.msg("请选择要删除的角色");
           return;
       }

       layer.confirm("确认要删除吗？",{title:"删除",icon:3},function () {
            $.ajax({
                type:"get",
                url:"${pageContext.request.contextPath}/role/batchDel",
                data:{"ids":roleDelArr.join()},
                success:function (result) {
                    if (result == "ok"){
                        layer.msg("删除成功");
                        var condition = $("input[name='condition']").val();
                        getRoles(currentPagenum,condition);
                    }
                }
            })

       });

    });






    //新增用户提交
    $("#insertRole").click(function () {
        $.ajax({
            type:"post",
            url:"${pageContext.request.contextPath}/role/insertRole",
            data:$("#insertRoleModal form").serialize(),
            success:function (result) {
                if (result == "ok"){
                    $("#insertRoleModal").modal("hide");
                    getRoles(totalPages+1);
                    layer.msg("添加成功");
                }
            }

        })
    });




    //新增用户模态框显示
    $("#showInsertRoleBtn").click(function () {
        $("#insertRoleModal").modal("show");
    });





    getRoles(1);

    function getRoles(pageNum,condition){
        $("tbody").empty();
        $("tfoot ul").empty();
        $.ajax({
            url:"${pageContext.request.contextPath}/role/getRoles",
            type:"get",
            data:{"pageNum":pageNum,"condition":condition},
            success:function (pageInfo) {
                // console.log(pageInfo);
                currentPagenum = pageInfo.pageNum;
                totalPages = pageInfo.pages;
                initRolesList(pageInfo);
                initRoleNav(pageInfo);

            }
        });
    }

    //抽取角色列表的方法
    function initRolesList(pageInfo){
        $.each(pageInfo.list,function (index) {
            $('<tr>\n' +
                '<td>' + (index + 1) + '</td>\n' +
                '<td><input roleid="'+this.id+'" type="checkbox"></td>\n' +
                '<td>' + this.name + '</td>\n' +
                '<td>\n' +
                '   <button roleid="'+this.id+'" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\n' +
                '   <button roleid="'+this.id+'" type="button" class="btn btn-primary btn-xs updateRoleBtn"><i class=" glyphicon glyphicon-pencil"></i></button>\n' +
                '   <button roleid="'+this.id+'" type="button" class="btn btn-danger btn-xs deleteRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\n' +
                '</td>\n' +
                '</tr>').appendTo("tbody");


        });
    }

    //抽取分页方法
    function initRoleNav(pageInfo){
        //上一页设置
        if (pageInfo.isFirstNode){
            $('<li class="disabled"><a href="javascript:void(0)">上一页</a></li>').appendTo("tfoot ul")
        }else{
            $('<li><a  class="navA" pagenum='+(pageInfo.pageNum - 1) +' href="javascript:void(0)">上一页</a></li>').appendTo("tfoot ul")
        };


        $.each(pageInfo.navigatepageNums,function () {
            if (this == pageInfo.pageNum){
                $('<li class="active"><a href="javascript:void(0)">'+this+' <span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul")
            }else {
                $('<li ><a class="navA" pagenum='+this +' href="javascript:void(0)">'+this+'</a></li>').appendTo("tfoot ul")
            }
        });

        if (pageInfo.isLastNode){
            $('<li class="disabled"><a href="javascript:void(0)">下一页</a></li>').appendTo("tfoot ul")
        }else{
            $('<li ><a class="navA" pagenum='+(pageInfo.pageNum + 1) +' href="javascript:void(0)">下一页</a></li>').appendTo("tfoot ul")
        }
    }





    $("tfoot").delegate(".navA","click",function () {
        var pagenum = $(this).attr("pagenum");
        var condition = $("input[name = 'condition'] ").val();
        getRoles(pagenum,condition);
    });

    $("#queryRolesBtn").click(function () {
        var condition = $("input[name = 'condition'] ").val();
        getRoles(1,condition);
    });


    //单个删除操作
    $("tbody").delegate(".deleteRoleBtn","click",function () {
       var $tr = $(this).parents("tr");
       var roleId = $(this).attr("roleid");
       var roleName = $(this).parents("tr").find("td:eq(2)").text();
       layer.confirm("你确定要删除 "+roleName+ " 吗？",{title:"删除",icon:3},function () {
           $.ajax({
               type:"get",
               url:"${pageContext.request.contextPath}/role/delete",
               data:{"id":roleId},
               success:function (result) {
                   if (result == "ok"){
                       layer.msg("删除成功");
                       $tr.remove();

                       if ($("tbody ul").length == 0){
                           var condition = $("input[name='condition']").val();
                           getRoles(currentPagenum , condition);
                       }
                   }
               }
           })
       })


    });


    <%--$("tbody").delegate(".deleteRoleBtn","click",function () {--%>
        <%--//一定要在此获取被点击按钮所在行的标签--%>
        <%--var $tr = $(this).parents("tr");//后台响应成功需要删除tr对象--%>
        <%--var roleid = $(this).attr("roleid");//异步请求删除角色的id--%>
        <%--layer.confirm("您确认删除吗?", {title:"删除提示:" , "icon":3} , function () {--%>
            <%--$.ajax({--%>
                <%--type:"get",--%>
                <%--url:"${pageContext.request.contextPath}/role/delete",--%>
                <%--data:{"id":roleid},--%>
                <%--success:function (result) {--%>
                    <%--if(result=="ok"){--%>
                        <%--layer.msg("删除成功");--%>
                        <%--//删除当前按钮所在行的角色标签--%>
                        <%--$tr.remove();--%>
                        <%--//判断本次删除之后页面中是否还有角色数据--%>
                        <%--if($("tbody tr").length===0){--%>
                            <%--//tbody内没有角色列表数据，刷新当前页--%>
                            <%--var condition = $("input[name='condit ion']").val();--%>
                            <%--getRoles(currentPagenum , condition);--%>
                        <%--}--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>
        <%--})--%>

    <%--});--%>





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

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
</script>
</body>
</html>

