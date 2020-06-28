<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./index_styles.css" />
<link rel="shortcut icon" type="image⁄x-icon" href="./images/lgtwins.png" />
<title>Sign in</title>
</head>
<body>
	<header>
		<div style="height: 20%; background-color: lightskyblue; padding: 50px 20px;">
			<h1 style="width: 90%; text-align: center; display: inline-block;">
				<a id="main_title" href="./index.jsp">아무말 대잔치</a>
			</h1>
			<div style="float: right;">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href=./signIn.jsp">Sign in</button>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href=./addUser.jsp">Sign up</button>
			</div>
		</div>


		<div style="height: 20px"></div>
	</header>
	<div style="position: relative; float: left;">
		<nav style="float: left;">
			<aside id="sidebar">
				<div id="category">
					<div>
						<div id="category_title">
							Category
							<div style="position: relative; float: right; padding-left: 120px">
								<img src="./images/plus.png" width="25px" height="20px">
							</div>
						</div>
					</div>
					<ul class="category_list">
						<li class="big_list">기술공간
							<ul class="small_list">
								<li>React</li>
								<li>Spring</li>
								<li>C/C++</li>
							</ul>
						</li>
						<li class="big_list">여행공간
							<ul class="small_list">
								<li>스페인</li>
								<li>홍콩</li>
								<li>일본</li>
							</ul>
						</li>
						<li class="big_list">일상공간
							<ul class="small_list">
								<li>맛집 소개</li>
								<li>책</li>
								<li>유용한 정보들</li>
							</ul>
						</li>
					</ul>
				</div>
				<div>
					<input id="category_search" type="text" name="search" value="검색 내용을 입력하세요.">
					<button id="searchBtn" type="submit">검색</button>
				</div>
			</aside>
		</nav>
		<article style="padding-left: 30px; position: absolute; top: 0px; left: 240px; width: 300px; float: left;">
			<h2>Sign in</h2>
			<form name="f1" method="post" action="signInDo.jsp">
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label for="validationDefault01">ID</label> <input type="text" class="form-control" id="id" name="id" value="" required>
					</div>
				</div>
				<div class="form-row">
					<div class="col-md-12 mb-3">
						<label for="validationDefault03">Password</label> <input type="password" class="form-control" id="pwd" name="pwd" required>
					</div>
				</div>
				<div class="col text-center">
					<button class="btn btn-info btn-lg" type="submit">Sign in</button>
				</div>
			</form>
		</article>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>