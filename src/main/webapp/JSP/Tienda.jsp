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
        <%@include file="/INC/metas.inc"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Tienda</title>
    </head>
    <body>
        <%@include file="/INC/nav.inc"%>

        <!-- Cuerpo principal -->
        <div class= "flex justify-center items-center border-dotted border-4 border-orange-400 m-16 ">
            <div class="m-8">
                <form action="<%=request.getContextPath()%>/FrontController" method="post">
                    <div class="mb-10">
                        <label for="titulo" class="py-2 px-4 border-b border-gray-300 text-orange-800 text-3xl font-medium m-10">Seleccione un libro:</label>
                        <select id="titulo" name="titulo" class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md mt-5">
                            <!-- Opciones de libros -->
                            <option value="">----------------------------------------------------------------------------------------</option>
                            <option class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium" value="En_nombre_de_Dios">En nombre de Dios</option>
                            <option class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium" value="La_mate_porque_era_mia">La mat&eacute; porque era m&iacute;a</option>
                            <option class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium" value="Hasta_aqui_llege_y_no_volvi">Hasta aqu&iacute; lleg&eacute; y no volv&iacute;</option>
                            <option class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium" value="La_bala_que_torcio_la_esquina">La bala que torci&oacute; la esquina</option>
                            <option class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium" value="El_cuento_de_rabanos_y_pimientos">El cuento de rabanos y pimientos</option>
                        </select> 

                    </div>
                    <div class="mb-4">
                        <label for="cantidad" class="py-2 px-4 border-b border-gray-300 text-orange-800 text-2xl font-medium m-10">Cantidad:</label>
                        <div class="relative mt-1 rounded-md shadow-sm">
                            <div class="flex justify-center">
                                <input type="number" id="cantidad" name="cantidad" min="0" value="0" class="block w-24 px-3 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
                            </div>
                        </div>
                    </div>
                    <!-- Tabla de libros en el carrito -->
                    <table class="w-full border-collapse">
                        <thead>
                            <tr>
                                <th class="py-2 px-4 border-b border-gray-300 text-orange-800 text-xl font-medium">Título</th>
                                <th class="py-2 px-4 border-b border-gray-300 text-orange-800 text-xl font-medium">Cantidad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (!carritoVacio) { %>
                            <% for (Map.Entry<String, Integer> entry : libros.entrySet()) {%>
                            <tr>
                                <td class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium"><%= entry.getKey()%></td>
                                <td class="py-2 px-4 border-b border-gray-300 text-lime-800 text-lg font-medium"><%= entry.getValue()%></td>
                            </tr>
                            <% } %>
                            <% } else { %>
                            <tr>
                                <td colspan="2" class="py-2 px-4 border-b border-gray-300 text-yellow-600 text-xl font-bold">No hay libros en el carrito</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                    <div class="flex justify-center gap-4">
                        <button type="submit" name="accion" value="Crear" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Añadir a la cesta</button>
                        <button type="submit" <%= carritoVacio ? "disabled" : ""%> name="accion" value="Visualizar" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-gray-600 hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">Ver Carrito</button>
                        <button type="submit" <%= carritoVacio ? "disabled" : ""%> name="accion" value="Finalizar" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">Finalizar la compra</button>
                    </div>
                </form>
            </div>
        </div>
        <%@include file="/INC/footer.inc"%>
    </body>
</html>

