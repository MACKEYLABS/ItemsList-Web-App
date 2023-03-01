<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.ItemsEntity" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Things List Program</title>
    <style type="text/css">
        body {
            font-family: sans-serif;
            font-size: 1rem;
        }

        .container {
            display: flex;
            flex-direction: row;
            width: 100%;
            margin: 0 auto;
            max-width: 800px;
            padding: 2rem;
            box-sizing: border-box;
        }

        .container div {
            flex: 2 1 auto;
        }

        .container form {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            box-sizing: border-box;
            background-color: #f8f8f8;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .container form p {
            margin: 0;
            padding: 1rem 0;
        }

        .container form input[type="number"],
        .container form input[type="text"] {
            padding: 1rem;
            border-radius: 5px;
            font-size: 1rem;
            border: 1px solid #ccc;
            margin-bottom: 1rem;
            width: 100%;
            box-sizing: border-box;
        }

        .container form input[type="submit"] {
            width: 100%;
            height: 40px;
            padding: 5px;
            background-color: #008CBA;
            color: #fff;
            border-radius: 8px;
            border: none;
            font-size: 1rem;
            cursor: pointer;
        }

        table {
            margin-top: 2rem;
            font-size: 1rem;
            border-collapse: collapse;
            margin-left: 3rem;
            width: 100%;
            box-sizing: border-box;
        }

        table th,
        table td {
            padding: 0.5rem;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        table tbody tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        table caption {
            text-align: center;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

    </style>
</head>
<body>

<div class="container">
    <div>
        <form method="POST" action="items">

            <p>1: Add 2: Delete 3: Exit <input type='number' name='action' min='1' max='3' placeholder="Choose an action" > </p>
            <p>Input Item: (Add Only) <input type='text' name='item' placeholder="Item Name" > </p>
            <p>ID #: (Deletion Only) <input title="ID for item to be deleted" type="text" name="id" placeholder="Item ID # for deletion"> </p>

            <p><input type='submit' value='Submit'></p>
        </form>
    </div>
    <table align="left" border="1">
        <caption align="center">Item List</caption>
        <thead>
        <tr>
            <th>ID</th>
            <th>Item</th>
        </tr>
        </thead>
        <tbody>
        <% List<ItemsEntity> items = (List<ItemsEntity>) request.getAttribute("items"); %>
        <% if (items != null && !items.isEmpty()) { %>
        <% for (ItemsEntity item : items) { %>
        <tr>
            <td><%= item.getId() %></td>
            <td><% String highlighted = request.getParameter("highlighted"); %><%= (highlighted != null && item.getItem().contains(highlighted)) ? item.getItem().replace(highlighted, "<span style='background-color: #FFFF00'>" + highlighted + "</span>") : item.getItem() %></td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="2">No items found</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
