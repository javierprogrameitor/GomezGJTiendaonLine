package es.albarregas.models;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author javier
 */
public class Modificador {

    public Cookie crearCookie(String titulo, int cantidad) {
        Cookie nuevoLibroCookie = null;
        if (titulo != null && !titulo.isEmpty() && cantidad != 0) {
            nuevoLibroCookie = new Cookie("libro_" + titulo, String.valueOf(cantidad));
            nuevoLibroCookie.setMaxAge(7 * 24 * 60 * 60); // una semana de cookie 
        }

        return nuevoLibroCookie;
    }

    public Cookie aumentar(String titulo, int cantidad) {

        Cookie nuevoLibroCookie = new Cookie("libro_" + titulo, String.valueOf(cantidad + 1));
        nuevoLibroCookie.setMaxAge(7 * 24 * 60 * 60); // un año de cookie    

        return nuevoLibroCookie;
    }

    public Cookie disminuir(String titulo, int cantidad) {

        Cookie otroLibroCookie = new Cookie("libro_" + titulo, String.valueOf(cantidad - 1));
        otroLibroCookie.setMaxAge(7 * 24 * 60 * 60); // un año de cookie                

        return otroLibroCookie;
    }

    public Cookie eliminar(String titulo, int cantidad) {

        Cookie otroLibroCookie = new Cookie("libro_" + titulo, String.valueOf(cantidad));
        otroLibroCookie.setMaxAge(0); // eliminamos cookie             

        return otroLibroCookie;
    }

    public void eliminarCarrito(HttpServletRequest request, HttpServletResponse response) {
        // Eliminar todos los libros del carrito de la sesión
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
    }



}
