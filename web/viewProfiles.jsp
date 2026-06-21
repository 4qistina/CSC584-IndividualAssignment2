<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.ProfileBean" %>

<%
    List<ProfileBean> profileList =
            (List<ProfileBean>) request.getAttribute("profileList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>All Profiles</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <link rel="stylesheet" href="CSS/viewProfilesCSS.css">
</head>
<body>

<div class="page-wrap">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1><i class="ti ti-users" aria-hidden="true"></i> All Profiles</h1>
            <p>Browse and manage student records</p>
            <div class="divider"></div>
        </div>
        <a href="index.jsp" class="new-btn">
            <i class="ti ti-user-plus" aria-hidden="true"></i>
            Add New Profile
        </a>
    </div>

    <!-- Search -->
    <div class="search-wrapper">
        <i class="ti ti-search" aria-hidden="true"></i>
        <input type="text"
               id="search"
               class="search-input"
               placeholder="Search by Student ID, Name, or Programme..."
               onkeyup="searchTable()">
    </div>

    <!-- Table -->
    <div class="table-wrap">
        <table class="profile-table" id="profileTable">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Programme</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                if (profileList == null || profileList.isEmpty()) {
            %>
                <tr>
                    <td colspan="5" class="empty-row">
                        No profiles found.
                        <a href="index.jsp">Create one →</a>
                    </td>
                </tr>
            <%
                } else {
                    for (ProfileBean profilebean : profileList) {
            %>
                <tr>
                    <td><%= profilebean.getStudentID() %></td>
                    <td><%= profilebean.getName() %></td>
                    <td><%= profilebean.getProgramme() %></td>
                    <td><%= profilebean.getEmail() %></td>
                    <td>
                        <div class="action-links">
                            <a href="ProfileServlet?view=<%= profilebean.getStudentID() %>" class="view-btn">
                                <i class="ti ti-eye" aria-hidden="true"></i> View
                            </a>
                            <a href="ProfileServlet?edit=<%= profilebean.getStudentID() %>" class="edit-btn">
                                <i class="ti ti-pencil" aria-hidden="true"></i> Edit
                            </a>
                            <a href="ProfileServlet?delete=<%= profilebean.getStudentID() %>"
                               class="delete-btn"
                               onclick="return confirm('Delete <%= profilebean.getName() %>?')">
                                <i class="ti ti-trash" aria-hidden="true"></i> Delete
                            </a>
                        </div>
                    </td>
                </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>

    <p id="resultCount" class="table-footer"></p>

</div>

<script>
    function searchTable() {
        const input = document.getElementById("search").value.toLowerCase();
        const rows = document.querySelectorAll("#profileTable tbody tr");
        let visible = 0;

        rows.forEach(row => {
            if (row.cells.length < 4) return;
            const id        = row.cells[0].innerText.toLowerCase();
            const name      = row.cells[1].innerText.toLowerCase();
            const programme = row.cells[2].innerText.toLowerCase();
            const match = id.includes(input) || name.includes(input) || programme.includes(input);
            row.style.display = match ? "" : "none";
            if (match) visible++;
        });

        document.getElementById("resultCount").textContent =
            input ? (visible + " result(s) found") : "";
    }
</script>

</body>
</html>