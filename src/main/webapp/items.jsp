<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entity.ItemsEntity" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Things List Program</title>
    <style type="text/css">
        .container {
            display: flex;
            flex-direction: row;
            width: 100%;
        }

        .container div {
            flex: 2 1 auto;
        }

        .container table{
            flex: 2 1 auto;
        }

        div {

        }

        form {
            font-size: 1.5rem;
        }

        table {
            margin-top: 20px;
            font-size: 1.4rem;
            border-collapse: collapse;
            margin-left: 3rem;
        }

        input[type="text"] {
            padding: 10px;
            border-radius: 5px;
            font-size: 1rem;
        }

        input[type="submit"] {
            width: 150px;
            height: 40px;
            padding: 5px;
            background-color: #008CBA;
            color: #fff;
            border-radius: 8px;
            border: none;
            font-size: 1.0em;
        }
    </style>
</head>
<body>

<div class="container">
    <div>
        <form method="POST" action="items">
            <p>Enter a number from the choices below</p>
            <p>1. Add an Item</p>
            <p>2. Delete an Item</p>
            <p>3. Exit the Program</p>
            <p><input type='number' name='action' min='1' max='3'></p>
            <p>Item to be insert: <input type='text' name='item' placeholder="Item Name" ></p>
            <%--     <p>ID: <input title="ID for item to be deleted" type="text" placeholder="ID for item to be deleted"> </p> --%>
            <p>ID: <input title="ID for item to be deleted" type="text" name="id" placeholder="ID for item to be deleted"> </p>

            <p><input type='submit' value='Submit'></p>
        </form>
    </div>
    <table align="left" border="1">
        <caption align="center">All Items</caption>
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
