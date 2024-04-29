package es.albarregas.controllers;

import es.albarregas.beans.Libro;
import es.albarregas.models.Modificador;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author javier
 */
@WebServlet(name = "SecondController", urlPatterns = {"/SecondController"})
public class SecondController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

  
            //Continuamos con la compra de libros
            Libro libros = new Libro();
            Modificador modify = new Modificador();
            String action = request.getParameter("accion");

            switch (action) {

                case "Comprar":
                    Map<String, Double> preciosLibros = new HashMap<>();
                    preciosLibros.put("En_nombre_de_Dios", 25.30);
                    preciosLibros.put("La_mate_porque_era_mia", 18.45);
                    preciosLibros.put("Hasta_aqui_llege_y_no_volvi", 32.60);
                    preciosLibros.put("La_bala_que_torcio_la_esquina", 41.54);
                    preciosLibros.put("El_cuento_de_rabanos_y_pimientos", 72.62);
                    request.setAttribute("preciosLibros", preciosLibros);

                    request.getRequestDispatcher("JSP/Factura.jsp").forward(request, response);
                    break;
                case "EliminarCarrito":

                    modify.eliminarCarrito(request, response);

                    request.getRequestDispatcher("JSP/Carrito.jsp").forward(request, response);
                    break;

                case "Seguir":
                    request.getRequestDispatcher("JSP/Tienda.jsp").forward(request, response);
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
