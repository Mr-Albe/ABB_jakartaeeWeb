
package services;

import java.util.List;
import java.sql.*;

/**
 *
 * @author Albe
 */
public interface IdaO<T> {
    boolean ajouter(T obj) throws ClassNotFoundException, SQLException;            
    boolean modifier(T obj) throws ClassNotFoundException, SQLException;           
    boolean supprimer(int id) throws ClassNotFoundException, SQLException;        
    T rechercherParId(int id) throws ClassNotFoundException, SQLException;       
    List<T> afficherTout() throws ClassNotFoundException, SQLException;         
}


 