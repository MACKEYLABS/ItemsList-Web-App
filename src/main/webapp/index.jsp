<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to my Item List Program</title>
    <style>
        h1 {
            text-align: center;
            margin-top: 20%;
            font-size: 4em;
        }

        button {
            display: block;
            margin: 0 auto;
            font-size: 1.5em;
            padding: 0.5em 1em;
            border-radius: 0.25em;
            border: none;
            background-color: #008CBA;
            color: #fff;
            cursor: pointer;
        }
    </style>
</head>
<body>
<h1>Welcome to MackeyLab's Item List Program</h1>
<form action="/ItemListWebApp_war_exploded/items">
    <button type="submit">Enter</button>
</form>
</body>
</html>