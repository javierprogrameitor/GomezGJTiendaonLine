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

@WebServlet(name = "FrontController", urlPatterns = {"/FrontController"})
public class FrontController extends HttpServlet {

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

            case "Crear":

                if (titulo != null && cantidad != 0) {
                    // Agregar el libro al carrito y guardar la cookie
                    libros.put(titulo, cantidad);
                    response.addCookie(modify.crearCookie(titulo, cantidad));
                    session.setAttribute("libros", libros);
                    request.getRequestDispatcher("JSP/Tienda.jsp").forward(request, response);
                    
                } else {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }

                break;
            case "Visualizar":

                //Visualizar los libros seleccionados de la Tienda
                session.setAttribute("libros", libros);

                request.getRequestDispatcher("JSP/Carrito.jsp").forward(request, response);
                break;

            case "Finalizar":
                Map<String, Double> preciosLibros = new HashMap<>();
                preciosLibros.put("En_nombre_de_Dios", 25.30);
                preciosLibros.put("La_mate_porque_era_mia", 18.45);
                preciosLibros.put("Hasta_aqui_llege_y_no_volvi", 32.60);
                preciosLibros.put("La_bala_que_torcio_la_esquina", 41.54);
                preciosLibros.put("El_cuento_de_rabanos_y_pimientos", 72.62);
                request.setAttribute("preciosLibros", preciosLibros);

                request.getRequestDispatcher("JSP/Factura.jsp").forward(request, response);

                break;
            default:
                request.getRequestDispatcher("JSP/Tienda.jsp").forward(request, response);
        }

    }

    /**
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("JSP/Tienda.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
