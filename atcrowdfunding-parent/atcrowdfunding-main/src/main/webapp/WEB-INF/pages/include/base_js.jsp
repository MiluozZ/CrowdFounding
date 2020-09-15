<%--
  Created by IntelliJ IDEA.
  User: Miluo
  Date: 2020/9/13
  Time: 19:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>

<script type="text/javascript">
    $(function () {
        $("#logout").click(function () {
            layer.confirm("确认要退出管理系统吗？",{"title":"退出","icon":3},function () {
                window.location.href="${pageContext.request.contextPath}/"
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