<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Map<String, Integer> libros = (Map<String, Integer>) request.getSession().getAttribute("libros");
    Map<String, Double> preciosLibros = (Map<String, Double>) request.getAttribute("preciosLibros");
    boolean carritoVacio = libros == null || libros.isEmpty();

    double precioTotal = 0;
    double precioIva;
    double pagar = 0;

    if (!carritoVacio) {
        for (Map.Entry<String, Integer> entry : libros.entrySet()) {
            String titulo = entry.getKey();
            int cantidad = entry.getValue();
            double precioUnitario = preciosLibros.get(titulo);
            double importe = precioUnitario * cantidad;
            precioTotal += importe;  // Sumar el importe de cada libro al precioTotal
        }
        precioIva = precioTotal * 0.04;  // Calcular el precioIva después del bucle
        pagar = precioTotal + precioIva;  // Calcular el total a pagar después del bucle
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Factura</title>
    </head>
    <body>
        <%@include file="/INC/nav.inc"%>
        <!--Cuerpo principal-->
        <div class="flex-column justify-items-center justify-center border-dotted border-4 border-orange-400 m-24">
            <table class="w-full">
                <thead>
                    <tr>
                        <th class="py-2 px-4 text-left bg-gray-200 text-blue-800 font-bold">Cantidad</th>
                        <th class="py-2 px-4 text-left bg-gray-200 text-blue-800 font-bold">Título</th>
                        <th class="py-2 px-4 text-left bg-gray-200 text-blue-800 font-bold">Precio Unidad</th>
                        <th class="py-2 px-4 text-left bg-gray-200 text-blue-800 font-bold">Importe</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (!carritoVacio) { %>
                    <% for (Map.Entry<String, Integer> entry : libros.entrySet()) {%>
                    <tr>
                        <td class="py-2 px-4 border-b border-gray-300 text-lime-800 font-bold"><%= entry.getValue()%></td>
                        <td class="py-2 px-4 border-b border-gray-300 text-orange-800 font-bold"><%= entry.getKey()%></td>
                        <td class="py-2 px-4 border-b border-gray-300 text-lime-800 font-bold"><%= String.format("%.2f", preciosLibros.get(entry.getKey()))%><a class="text-lime-800 font-bold">€</a></td>
                        <td class="py-2 px-4 border-b border-gray-300 text-lime-800 font-bold"><%= String.format("%.2f", preciosLibros.get(entry.getKey()) * entry.getValue())%><a class="text-lime-800 font-bold">€</a></td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr class="flex justify-items-center justify-center m-5">
                        <td colspan="4" class="py-2 px-4 border-b border-gray-300 text-yellow-600 text-xl font-bold">No hay libros en el carrito</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <table class="flex justify-items-center justify-center m-10">
                <tbody>
                    <tr>
                        <td class="py-2 px-4 text-orange-800 font-bold">Base Imponible:</td>
                        <td class="py-2 px-4 text-lime-800 font-bold"><%= String.format("%.2f", precioTotal)%><a class="text-lime-800 font-bold">€</a></td>
                    </tr>
                    <tr>
                        <td class="py-2 px-4 text-orange-800 font-bold">IVA 4%:</td>
                        <td class="py-2 px-4 text-lime-800 font-bold"><%= String.format("%.2f", precioTotal * 0.04)%><a class="text-lime-800 font-bold">€</a></td>
                    </tr>
                    <tr>
                        <td class="py-2 px-4 text-orange-800 font-bold">Importe a pagar en euros:</td>
                        <td class="py-2 px-4 text-red-800 font-bold"><%= String.format("%.2f", pagar)%><a class="text-red-800 font-bold">€</a></td>
                    </tr>
                </tbody>
            </table>

            <div class="flex justify-center items-center m-5">
                <form action="<%= request.getContextPath()%>/Return" method="post">
                    <button type="submit" name="gracias" class="bg-green-500 text-white px-8 py-4 text-center text-lg font-bold rounded-lg shadow-md hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 focus:ring-offset-gray-200">Gracias por su confianza</button>
                </form>
            </div>
        </div>


        <%@include file="/INC/footer.inc"%>
    </body>
</html>
