<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Llibres - Resultats de la consulta</title>
    
    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJvM6LZyFsztVx5Rkc3uH0fo0VGOoPZsqKbb9FIlTH0fZlV5nFfqkzdYbzrJ" crossorigin="anonymous">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa;
            padding: 20px;
        }

        h1 {
            color: #333;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }

        .table-container {
            margin-top: 30px;
        }

        .table th, .table td {
            vertical-align: middle;
            padding: 15px;
        }

        /* Personalización de colores */
        .table {
            background-color: #fff;
        }

        .table th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: left;
        }

        /* Hover effect para las filas */
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        /* Fila de error */
        .error-message {
            text-align: center;
            color: red;
            font-weight: bold;
            padding: 15px;
            background-color: #fff3f3;
            border: 1px solid red;
        }

        /* Espaciado general */
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .card {
            background-color: #ffffff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Resultats de la consulta</h1>

        <div class="card">
            <div class="table-container">
                <table class="table table-bordered table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Títol</th>
                            <th>ISBN</th>
                            <th>Any Publicació</th>
                            <th>Editorial</th>
                            <th>Autors</th>
                            <th>Gèneres</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String url = "jdbc:mariadb://localhost:3306/llibres";
                            String user = "root";
                            String password = ""; // Cambiar si es necesario

                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;

                            try {
                                Class.forName("org.mariadb.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, password);
                                stmt = conn.createStatement();

                                String query = "SELECT l.titol, l.isbn, l.any_publicacio, e.nom AS editorial, " +
                                               "GROUP_CONCAT(DISTINCT a.nom SEPARATOR ', ') AS autors, " +
                                               "GROUP_CONCAT(DISTINCT g.nom SEPARATOR ', ') AS generes " +
                                               "FROM llibres l " +
                                               "LEFT JOIN editorials e ON l.id_editorial = e.id " +
                                               "LEFT JOIN llibre_autor la ON l.id = la.id_llibre " +
                                               "LEFT JOIN autors a ON la.id_autor = a.id " +
                                               "LEFT JOIN llibre_genere lg ON l.id = lg.id_llibre " +
                                               "LEFT JOIN generes g ON lg.id_genere = g.id " +
                                               "GROUP BY l.id, l.titol, l.isbn, l.any_publicacio, e.nom";

                                rs = stmt.executeQuery(query);

                                while (rs.next()) {
                                    String titol = rs.getString("titol");
                                    String isbn = rs.getString("isbn");
                                    int anyPublicacio = rs.getInt("any_publicacio");
                                    String editorial = rs.getString("editorial");
                                    String autors = rs.getString("autors");
                                    String generes = rs.getString("generes");
                        %>
                                    <tr>
                                        <td><%= titol %></td>
                                        <td><%= isbn %></td>
                                        <td><%= anyPublicacio %></td>
                                        <td><%= editorial %></td>
                                        <td><%= autors %></td>
                                        <td><%= generes %></td>
                                    </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                                <tr class="error-message">
                                    <td colspan="6">Error al obtenir les dades: <%= e.getMessage() %></td>
                                </tr>
                        <%
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0v8Fq1nG5X9bFJ5q3zY3Y3vGnYxI4IRw8+NcDOqqQoe++nt2" crossorigin="anonymous"></script>
</body>
</html>
