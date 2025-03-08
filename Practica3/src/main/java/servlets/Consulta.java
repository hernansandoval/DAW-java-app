package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet para realizar consultas a la base de datos.
 *
 * @author hernan
 */
@WebServlet(name = "Consulta", urlPatterns = {"/Consulta"})
public class Consulta extends HttpServlet {

    /**
     * Método que maneja las solicitudes GET para recuperar datos.
     *
     * @param request Objeto HttpServletRequest
     * @param response Objeto HttpServletResponse
     * @throws ServletException Si ocurre un error en el servlet
     * @throws IOException Si ocurre un error de entrada/salida
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (Connection conn = Connexio.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM llibres")) {

            List<String> resultats = new ArrayList<>();
            while (rs.next()) {
                resultats.add(rs.getString("titol"));
            }

            response.getWriter().write("<h1>Llibres Disponibles</h1>");
            for (String llibre : resultats) {
                response.getWriter().write("<p>" + llibre + "</p>");
            }

        } catch (Exception e) {
            response.getWriter().write("Error en la consulta: " + e.getMessage());
        }
    }
}
