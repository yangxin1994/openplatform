<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src=<%= request.getContextPath() + "/js/basic/addTag.js" %> type="text/javascript"></script>
</head>
<body>
	<div>
		<div class="modal-body">
		    <form id="addForm" name="addForm" method="post" class="form-horizontal" role="form">
		        <div class="form-group">
		        	<label for="name" class="col-sm-2 control-label">标签名称</label>
		        	<div class="col-sm-10">
		        		<input type="text" id="name" name="name" class="form-control" placeholder="请输入标签名称" />
		        	</div>
		        </div>
				<div class="form-group">
					<label for="topicId" class="col-sm-2 control-label">所属主题</label>
					<div class="col-sm-10">
						<select class="form-control" id="topicId" name="topicId">
							<c:forEach items="${topics}" var="topics">
                           		<c:if test="${topics.position == '01'}">
                           			<option value=${topics.id}>${topics.name}(内网)</option>
								</c:if>
								<c:if test="${topics.position == '03'}">
									<option value=${topics.id}>${topics.name}(外网)</option>
								</c:if>
                           	</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="remark" class="col-sm-2 control-label">备注</label>
					<div class="col-sm-10">
						<textarea class="form-control" name="remark" rows="3"></textarea>
					</div>
				</div>
		    </form>
		</div>
	</div>
	<div class='notifications'></div>
</body>
</html>