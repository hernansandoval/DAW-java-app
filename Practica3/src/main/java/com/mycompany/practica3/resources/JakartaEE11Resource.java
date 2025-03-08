package com.mycompany.practica3.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

/**
 * Recurso REST para probar la conexión a Jakarta EE.
 *
 * @author hernan
 */
@Path("jakartaee11")
public class JakartaEE11Resource {

    /**
     * Método que devuelve un mensaje de prueba.
     *
     * @return Respuesta HTTP con el mensaje "ping Jakarta EE"
     */
    @GET
    public Response ping() {
        return Response
                .ok("ping Jakarta EE")
                .build();
    }
}
