package servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos.
 *
 * @author hernan
 */
public class Connexio {
    private static final String URL = "jdbc:mariadb://localhost:3306/llibres"; 
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    /**
     * Método para obtener la conexión a la base de datos.
     *
     * @return Objeto Connection para interactuar con la base de datos.
     * @throws SQLException Si hay un error en la conexión.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error al cargar el driver de MariaDB", e);
        }
    }
}
