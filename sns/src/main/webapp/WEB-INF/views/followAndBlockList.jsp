<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kor">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<%
String contextPath = request.getContextPath();
%>
<link id="theme-setting" rel="stylesheet" href="<%=(String)session.getAttribute("curTheme")%>">
<link rel="stylesheet" href="<%=contextPath%>/resources/css/followAndBlockList.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
    integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
    crossorigin="anonymous" referrerpolicy="no-referrer">
</script>
<body class="theme">
    <span id="fnb-back-btn"><a href="/sns/main" class="theme">&lang; BACK</a></span>
    <h1>Follow and Blocked List</h1>
    <div id="fnbList">
        <table>
            <thead>
                <tr>
                    <td colspan="2">
                        <label id="type-followings">
                            FOLLOWINGS
                        </label>
                    </td>
                    <td colspan="2" style="width: calc(100% / 3);">
                        <label id="type-allFollowers">
                            FOLLOWERS
                        </label>
                    </td>
                    <td colspan="2" style="width: calc(100% / 3);">
                        <label id="type-blocked">
                            BLOCKED
                        </label>
                    </td>
                </tr>
            </thead>
            <tbody id="followingsList">
            	<c:forEach items="${followings }" var="fProf">
            		<c:if test="${not empty fProf }">
		                <tr>
		                    <td class="fnb-img-td">
		                        <div class="fnb-img-div">
		           					<c:choose>
			           					<c:when test="${empty fProf.photo}">
			                            	<img src="<%=contextPath%>/resources/img/프로필.png">
	                   					</c:when>
		                            	<c:otherwise>
		                            		<img src="download?filename=${fProf.photo}">
		                           		</c:otherwise>
	                           		</c:choose> 
		                        </div>
		                    </td>
		                    <td colspan="4" class="fnb-username-td">
		                        <span class="fnb-nickname">${fProf.nickName}</span>
		                        (<span class="fnb-id">${fProf.id}</span>)
		                        <input type="hidden" name="privacy" class="priv" value="${fProf.privacy }">
		                    </td>
		                    <td class="fnb-btns-td">
		                        <button type="button" class="fnb-btn fnb-follow-btn theme" value="1">FOLLOWING</button>
		                    </td>
		                </tr>
	                </c:if>
                </c:forEach>
            </tbody>
            <tbody id="allFollowersList">
            	<c:forEach items="${interfollowers }" var="fProf">
            		<c:if test="${not empty fProf }">
		                <tr>
		                    <td class="fnb-img-td">
		                        <div class="fnb-img-div">
		                  			<c:choose>
			                        	<c:when test="${empty fProf.photo}">
			                            	<img src="<%=contextPath%>/resources/img/프로필.png">
		                   				</c:when>
		                            	<c:otherwise>
		                            		<img src="download?filename=${fProf.photo}">
		                           		</c:otherwise>
	                           		</c:choose>
		                        </div>
		                    </td>
		                    <td colspan="4" class="fnb-username-td">
		                        <span class="fnb-nickname">${fProf.nickName}</span>
		                        (<span class="fnb-id">${fProf.id}</span>)
		                        <input type="hidden" name="privacy" class="priv" value="${fProf.privacy }">
		                    </td>
		                    <td class="fnb-btns-td">
		                        <button type="button" class="fnb-btn fnb-follow-btn theme" value="1">FOLLOWING</button>
		                    </td>
		                </tr>
	                </c:if>
                </c:forEach>
                <c:forEach items="${followers }" var="fProf">
              		<c:if test="${not empty fProf }">
		                <tr>
		                    <td class="fnb-img-td">
		                        <div class="fnb-img-div">
		                			<c:choose>
			                        	<c:when test="${empty fProf.photo}"> 
			                            	<img src="<%=contextPath%>/resources/img/프로필.png">
		                        		</c:when>
		                            	<c:otherwise>
		                            		<img src="download?filename=${fProf.photo}">
		                           		</c:otherwise>
	                           		</c:choose> 
		                        </div>
		                    </td>
		                    <td colspan="4" class="fnb-username-td">
		                        <span class="fnb-nickname">${fProf.nickName}</span>
		                        (<span class="fnb-id">${fProf.id}</span>)
		                        <input type="hidden" name="privacy" class="priv" value="${fProf.privacy }">
		                    </td>
		                    <td class="fnb-btns-td">
		                        <button type="button" class="fnb-btn fnb-follow-btn theme" value="0">FOLLOW</button>
		                    </td>
		                </tr>
	                </c:if>
                </c:forEach>
            </tbody>
            <tbody id="blockedList">
                <tr>
                    <td class="fnb-img-td">
                        <div class="fnb-img-div">
                            <img src="">
                        </div>
                    </td>
                    <td colspan="4" class="fnb-username-td">
                        <span class="fnb-nickname">nick</span>
                        <span class="fnb-id">id</span>
                    </td>
                    <td class="fnb-btns-td">
                        <button type="button" class="fnb-btn fnb-block-btn theme">BLOCKED</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
<script>

	// window.location.href로 url 가져와서 식별자 다르게 한 다음
	// followings, followers, blocked list 각각 출력하자.
	// followList.jsp에도 적용 가능할 듯.

    $(document).ready(function() {
        let url = window.location.href.split('/');
        let curList = $.trim(url[url.length-1]);
        console.log(`curList: \${curList}`);
		
        $('label[id^=type-]').css('color', 'grey');
        $('tbody[id$=List]').css('display', 'none');
        if (curList != '') {
        	$(`label[id*=\${curList} i]`).css('color', '')
        	$(`tbody[id*=\${curList} i]`).css('display', '')
        } else {
        	$('#type-followings').css('color', '');
        	$('#followingsList').css('display', '');
        }
    });

    // FOLLOWINGS FOLLOWERS BLOCKED 글자 누를 때 디자인 및 보이는 리스트 변화
    $('label[id^=type-]').on('click', function() {
        $('label[id^=type-]').css('color', 'grey');
        $(this).css('color', '');
        let curType = $(this).text().substring(5);
        $('tbody[id$=List]').css('display', 'none');
        $(`tbody[id*=\${curType} i]`).css('display', '');
    });
    
    $('tbody').on('click', '.fnb-btns-td .fnb-follow-btn', function() {
    	let flag = followSwitch($(this));
    });
    
    
    function followSwitch(flag) {
    	if (flag.val() == 0) {
    		flag.val(1);
    		flag.text('FOLLOWING');
    	} else {
    		flag.val(0);
    		flag.text('FOLLOW');
    	}
    	return flag.val();
    }
    
    
    
    
    
    
    

</script>
</html>