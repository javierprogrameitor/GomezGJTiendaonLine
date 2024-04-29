<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="/INC/metas.inc"%>
        <meta http-equiv="refresh" content="3;url=./FrontController" charset="UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.10.1/dist/full.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <title>TiendaOnLine</title>
    </head>
    <body class="bg-green-600">
        <div class="flex justify-center items-center border-dotted border-4 border-orange-400">
            <%@include file="INC/cabezera.inc"%>       
            <h3 class="text-3xl text-orange-800 font-mono font-black p-20">Selecciona un libro por favor</h3>     
            <%@include file="INC/pie.inc"%>
        </div>
    </body>
</html>
