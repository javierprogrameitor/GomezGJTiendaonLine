<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar si hay libros en el carrito
    Map<String, Integer> libros = (Map<String, Integer>) request.getSession().getAttribute("libros");
    boolean carritoVacio = libros == null || libros.isEmpty();
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Ver Carrito</title>
    </head>
    <body>
        <%@include file="/INC/nav.inc"%>
        <div class=" border-dotted border-4 border-orange-400 m-36">
            <table class="w-full border-collapse">
                <thead>
                    <tr>
                        <th class="py-2 px-4 text-left bg-gray-200 text-orange-800 text-3xl font-medium m-10">T&iacute;tulo</th>
                        <th class="py-2 px-4 text-left bg-gray-200 text-orange-800 text-3xl font-medium m-10">Cantidad</th>
                        <th class="py-2 px-4 text-left bg-gray-200 text-orange-800 text-3xl font-medium m-10">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (!carritoVacio) { %>
                    <% for (Map.Entry<String, Integer> entry : libros.entrySet()) {%>
                    <tr>
                        <td class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium m-10"><%= entry.getKey()%></td>
                        <td class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium m-10"><%= entry.getValue()%></td>
                        <td class="py-2 px-4 border-b border-gray-300">
                            <form action="<%=request.getContextPath()%>/Buttons" method="post">
                                <input type="hidden" name="titulo" value="<%= entry.getKey()%>">
                                <input type="hidden" name="cantidad" value="<%= entry.getValue()%>">
                                <button type="submit" name="accion" value="Aumentar" class="bg-green-500 hover:bg-green-600 text-white px-2 py-1 rounded-md">+</button>
                                <button type="submit" name="accion" value="Disminuir" class="bg-yellow-500 hover:bg-yellow-600 text-white px-2 py-1 rounded-md">-</button>
                                <button type="submit" name="accion" value="EliminarLibro" class="bg-red-500 hover:bg-red-600 text-white px-2 py-1 rounded-md">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr class=" flex justify-center items-center m-5">
                        <td colspan="3" class="py-2 px-4 border-b border-gray-300 text-yellow-600 text-xl font-bold">No hay libros en el carrito</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
        <div class=" flex justify-center items-center m-10">
            <form action="<%= request.getContextPath()%>/SecondController" method="post" class="mt-4">
                <button type="submit" name="accion" value="Comprar" class="bg-blue-500 hover:bg-blue-600 text-white px-2 py-1 rounded-md">Comprar</button>
                <button type="submit" name="accion" value="EliminarCarrito" class="bg-red-500 hover:bg-red-600 text-white px-2 py-1 rounded-md">Eliminar carrito</button>
                <button type="submit" name="accion" value="Seguir" class="bg-gray-500 hover:bg-gray-600 text-white px-2 py-1 rounded-md">Seguir comprando</button>
            </form>
        </div>
        <%@include file="/INC/footer.inc"%>
    </body>
</html>
