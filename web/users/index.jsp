<%@page import="java.util.List"%>
<%@page import="model.StationModel"%>
<%    List<StationModel> listStation = (List<StationModel>) session.getAttribute("listStation");

    String erreur = (String) session.getAttribute("erreur");
    int stationCount = listStation != null ? listStation.size() : 0;

%>