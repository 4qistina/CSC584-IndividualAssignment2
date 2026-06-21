<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="Model.ProfileBean" %>

<%
    ProfileBean profilebean =
            (ProfileBean) request.getAttribute("profilebean");

    if (profilebean == null) {
        response.sendRedirect(request.getContextPath() + "/ProfileServlet");
        return;
    }

    String name         = profilebean.getName()         != null ? profilebean.getName()         : "";
    String studentID    = profilebean.getStudentID()    != null ? profilebean.getStudentID()    : "";
    String programme    = profilebean.getProgramme()    != null ? profilebean.getProgramme()    : "";
    String email        = profilebean.getEmail()        != null ? profilebean.getEmail()        : "";
    String hobbies      = profilebean.getHobbies()      != null ? profilebean.getHobbies()      : "";
    String introduction = profilebean.getIntroduction() != null ? profilebean.getIntroduction() : "";

    // Generate initials from name for avatar
    String initials = "";
    if (!name.isEmpty()) {
        String[] parts = name.trim().split("\\s+");
        for (String part : parts) {
            if (!part.isEmpty()) initials += part.charAt(0);
        }
        if (initials.length() > 2) initials = initials.substring(0, 2);
        initials = initials.toUpperCase();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile — <%= name %></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <link rel="stylesheet" href="CSS/profileCSS.css">
</head>
<body>

<h1>Personal Profile</h1>

<div class="container">

    <!-- Profile header with avatar -->
    <div class="profile-header">
        <div class="avatar">
            <% if (!initials.isEmpty()) { %>
                <span style="font-family:'Inter',sans-serif; font-size:1.4rem; font-weight:600; color:#d4537e;"><%= initials %></span>
            <% } else { %>
                <i class="ti ti-user" aria-hidden="true"></i>
            <% } %>
        </div>
        <h2><%= name %></h2>
        <p><%= programme %> &nbsp;·&nbsp; <%= studentID %></p>
        <div class="divider"></div>
    </div>

    <!-- Info rows -->
    <div class="info-box">
        <i class="ti ti-user info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Full Name</div>
            <div class="value"><%= name %></div>
        </div>
    </div>

    <div class="info-box">
        <i class="ti ti-id-badge info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Student ID</div>
            <div class="value"><%= studentID %></div>
        </div>
    </div>

    <div class="info-box">
        <i class="ti ti-school info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Programme</div>
            <div class="value"><%= programme %></div>
        </div>
    </div>

    <div class="info-box">
        <i class="ti ti-mail info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Email</div>
            <div class="value"><%= email %></div>
        </div>
    </div>

    <hr class="section-divider">

    <div class="info-box">
        <i class="ti ti-heart info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Hobbies</div>
            <div class="value"><%= hobbies %></div>
        </div>
    </div>

    <div class="info-box">
        <i class="ti ti-file-text info-icon" aria-hidden="true"></i>
        <div class="info-content">
            <div class="label">Introduction</div>
            <div class="value"><%= introduction %></div>
        </div>
    </div>

    <!-- Actions -->
    <div class="actions">
        <a href="index.jsp" class="btn-primary">
            <i class="ti ti-user-plus" aria-hidden="true"></i>
            Add New Profile
        </a>
        <a href="<%= request.getContextPath() %>/ProfileServlet" class="btn-outline">
            <i class="ti ti-users" aria-hidden="true"></i>
            View All Profiles
        </a>
    </div>

</div>

</body>
</html>