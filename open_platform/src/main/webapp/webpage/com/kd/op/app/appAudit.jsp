<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/context/mytags.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src=<%= request.getContextPath() + "/plug-in/bootstrap/js/bootstrapValidator.js" %> type="text/javascript"></script>
<script src=<%= request.getContextPath() + "/js/com/kd/op/app/auditApp.js" %> type="text/javascript"></script>
</head>
<body>
	<div>
		<div class="modal-body">
		    <form id="addForm" name="addForm" method="post" class="form-horizontal" role="form">
		    	<input type="hidden" id="id" name="id" value="${app.id}" />
		        <div class="form-group">
		        	<label for="appName" class="col-sm-2 control-label">应用名称</label>
		        	<div class="col-sm-8" style="padding-right:0px">
		        		<input type="text" id="appName" name="appName" readonly="readonly" class="form-control" value="${app.appName}" />
		        	</div>
		        </div>
		       <div class="form-group">
					<label for="appAauditStatus" class="col-sm-2 control-label">审核状态</label>
					<div class="col-sm-8" style="padding-right:0px">
						<select class="form-control" id="appAauditStatus" name="auditStatus">
								<option selected value="2">审核通过</option>
								<option  value="3">审核不通过</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="auditMsg" class="col-sm-2 control-label ">审核意见</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="auditMsg" name="auditMsg" rows="3"></textarea>
					</div>
				</div>
		    </form>
		</div>
	</div>
</body>
</html>
<%--<script>--%>
	<%--$(document).ready(function(){--%>
        <%--$("#btn_sub").bind("click",function(){--%>
                <%--var options={--%>
                    <%--url:"apiAppController.do?auditApp",--%>
                    <%--type:"post",--%>
                    <%--dataType:"json",--%>
                    <%--beforeSubmit:function(){--%>
                    <%--},--%>
                    <%--success:function(data){--%>
                        <%--if(data.success){--%>
                            <%--$(".bootstrap-dialog").modal("hide")--%>
                            <%--reloadTable();--%>
                            <%--quickNotify(data.msg,"success");--%>
                        <%--}else{--%>
                            <%--slowNotify(data.msg,"danger");--%>
                        <%--}--%>
                    <%--},--%>
                <%--}--%>
                <%--$("#addForm").ajaxSubmit(options);--%>
            <%--// }--%>
        <%--})--%>
	<%--})--%>
<%--</script>--%>