<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body>

<div class="section">
	<div class="slidewrap">
		<ul class="slidelist">
			<li>
				<a>
					<label for="slide03" class="left"></label>
					<img src="resources/images/slide01.jpg">
					<label for="slide02" class="right"></label>
				</a>
			</li>
			<li>
				<a>
					<label for="slide01" class="left"></label>
					<img src="resources/images/slide02.jpg">
					<label for="slide03" class="right"></label>
				</a>
			</li>
			<li>
				<a>
					<label for="slide02" class="left"></label>
					<img src="resources/images/slide03.jpg">
					<label for="slide01" class="right"></label>
				</a>
			</li>
		</ul>
	</div>

	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02" >
	<input type="radio" name="slide" id="slide03" >
	
	<div class="slide-control">
		<div class="control01">
			<label for="slide03" class="left"></label>
			<label for="slide02" class="right"></label>
		</div>
		<div class="control02">
			<label for="slide01" class="left"></label>
			<label for="slide03" class="right"></label>
		</div>
		<div class="control03">
			<label for="slide02" class="left"></label>
			<label for="slide01" class="right"></label>
		</div>
	</div>
</div>








	
	<div class="button_list">
		<button class="button_left">← Left</button>
		<button class="button_right">Right →</button>
	</div>
</body>
