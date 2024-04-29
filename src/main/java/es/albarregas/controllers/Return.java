package es.albarregas.controllers;

import java.io.IOException;
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
@WebServlet(name = "Return", urlPatterns = {"/Return"})
public class Return extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Eliminamos las cookies y volvemos al inicio 'index.jsp'
        HttpSession session = request.getSession();
        session.removeAttribute("libros");

        // Eliminar todas las cookies relacionadas con el carrito
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().startsWith("libro_")) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
