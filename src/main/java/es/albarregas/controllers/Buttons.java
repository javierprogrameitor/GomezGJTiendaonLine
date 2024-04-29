package es.albarregas.controllers;

import es.albarregas.beans.Libro;
import es.albarregas.models.Modificador;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author javier
 */
@WebServlet(name = "Buttons", urlPatterns = {"/Buttons"})
public class Buttons extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Libro book = new Libro();
        Modificador modify = new Modificador();

        HttpSession session = request.getSession();
        Map<String, Integer> libros = (Map<String, Integer>) session.getAttribute("libros");

        String action = request.getParameter("accion");

        String titulo = request.getParameter("titulo");
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        if (libros == null) {
            libros = new HashMap<>();

            // Obtener todas las cookies y verificar si hay alguna relacionada con el carrito
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().startsWith("libro_")) {
                        libros.put(cookie.getName().substring(6), Integer.parseInt(cookie.getValue()));
                    }
                }
            }
        }
        switch (action) {

            case "Aumentar":

                libros.put(titulo, cantidad + 1);

                book.setTitulo(titulo);
                book.setCantidad(cantidad);

                response.addCookie(modify.aumentar(titulo, cantidad));

                request.getRequestDispatcher("JSP/Carrito.jsp").forward(request, response);
                break;

            case "Disminuir":
                // Agregar el libro al carrito y guardar la cookie
                libros.put(titulo, cantidad - 1);

                book.setTitulo(titulo);
                book.setCantidad(cantidad);

                response.addCookie(modify.disminuir(titulo, cantidad));

                request.getRequestDispatcher("JSP/Carrito.jsp").forward(request, response);
                break;

            case "EliminarLibro":

                libros.remove(titulo, cantidad);
                response.addCookie(modify.eliminar(titulo, cantidad));

                request.getRequestDispatcher("JSP/Carrito.jsp").forward(request, response);
                break;
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
