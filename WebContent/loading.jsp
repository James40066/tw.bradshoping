<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body{
  
}
div.loader{
position:fixed;
  left:49%;
  top:49%;
  background: #FFFFFF;
  color: #777;
  font-family: "Gill sans", sans-serif;
  margin: 0 auto;
  }
h1{
  border-bottom: 1px dashed;
  font-weight: lighter;
}
p{
  font-style: italic;
}
.loader{
  width: 0%;
  display: inline-block;
  vertical-align: top;
}

/*
  Set the color of the icon
*/
svg path,
svg rect{
  fill: #FF6700;
}
</style>
</head>

<body>
<div class="loader loader--style3" title="2">
	  <svg version="1.1" id="loader-1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	     width="100px" height="100px" viewBox="0 0 50 50" style="enable-background:new 0 0 50 50;" xml:space="preserve">
	  <path fill="#000" d="M43.935,25.145c0-10.318-8.364-18.683-18.683-18.683c-10.318,0-18.683,8.365-18.683,18.683h4.068c0-8.071,6.543-14.615,14.615-14.615c8.072,0,14.615,6.543,14.615,14.615H43.935z">
	    <animateTransform attributeType="xml"
	      attributeName="transform"
	      type="rotate"
	      from="0 25 25"
	      to="360 25 25"
	      dur="0.6s"
	      repeatCount="indefinite"/>
	    </path>
	  </svg>
</div>
</body>
</html>