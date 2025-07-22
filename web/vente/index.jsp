
    <h1>Nouvelle vente</h1>

    <form action="${pageContext.request.contextPath}/VenteServlet" method="post">
        <label>ID Station:</label>
        <input type="number" name="stationId" required><br>

        <label>Type de carburant:</label>
        <select name="typeCarburant">
            <option value="gazoline">Gazoline</option>
            <option value="diesel">Diesel</option>
        </select><br>

        <label>Quantité:</label>
        <input type="number" name="quantite" required><br>

        <label>Prix unitaire:</label>
        <input type="number" step="0.01" name="prixUnitaire" required><br>

        <label>Date de vente:</label>
        <input type="date" name="dateVente" required><br>

        <button type="submit">Valider</button>
    </form>
