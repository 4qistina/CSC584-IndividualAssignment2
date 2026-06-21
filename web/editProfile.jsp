<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    int introLength = introduction.length();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Profile — <%= name %></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <link rel="stylesheet" href="CSS/editProfileCSS.css">
</head>

<body>

<div class="resume-wrap">

    <!-- Header -->
    <div class="form-header">
        <h1><i class="ti ti-user-edit" aria-hidden="true"></i> Edit Profile</h1>
        <p>Update your details below</p>
        <div class="divider"></div>
    </div>

    <!-- Edit banner -->
    <p class="edit-banner">
        <i class="ti ti-pencil" aria-hidden="true"></i>
        Editing: <b><%= name %></b>
    </p>

    <form action="<%= request.getContextPath() %>/ProfileServlet" method="post">

        <input type="hidden" name="action" value="update">

        <!-- Name + Student ID -->
        <div class="two-col">

            <div class="field-group">
                <label><i class="ti ti-user" aria-hidden="true"></i> Full Name</label>
                <input type="text"
                       name="name"
                       value="<%= name %>"
                       placeholder="Enter your full name"
                       required>
            </div>

            <div class="field-group">
                <label><i class="ti ti-id-badge" aria-hidden="true"></i> Student ID</label>
                <input type="text"
                       name="studentID"
                       value="<%= studentID %>"
                       readonly>
            </div>

        </div>

        <!-- Programme + Email -->
        <div class="two-col">

            <div class="field-group">
                <label><i class="ti ti-school" aria-hidden="true"></i> Academic Programme</label>
                <input type="text"
                       name="programme"
                       value="<%= programme %>"
                       placeholder="Enter your programme"
                       required>
            </div>

            <div class="field-group">
                <label><i class="ti ti-mail" aria-hidden="true"></i> Email</label>
                <input type="email"
                       name="email"
                       value="<%= email %>"
                       placeholder="Enter your email"
                       required>
            </div>

        </div>

        <hr class="section-divider">

        <!-- Hobbies -->
        <div class="field-group">
            <label><i class="ti ti-heart" aria-hidden="true"></i> Hobbies</label>
            <input type="text"
                   name="hobbies"
                   value="<%= hobbies %>"
                   placeholder="Enter hobbies separated by comma">
        </div>

        <hr class="section-divider">

        <!-- Introduction -->
        <div class="field-group">
            <label><i class="ti ti-file-text" aria-hidden="true"></i> Introduction</label>
            <textarea name="introduction"
                      rows="5"
                      maxlength="500"
                      id="intro"><%= introduction %></textarea>
            <p class="char-count">
                <span id="charCount"><%= introLength %></span> / 500
            </p>
        </div>

        <button type="submit" class="submit-btn">
            <i class="ti ti-device-floppy" aria-hidden="true"></i>
            Save Changes
        </button>

    </form>

    <p style="text-align:center; margin-top:1.5rem;">
        <a href="<%= request.getContextPath() %>/ProfileServlet">
            <i class="ti ti-arrow-left" aria-hidden="true"></i> Back to all profiles
        </a>
    </p>

</div>

<script>
    const intro     = document.getElementById("intro");
    const charCount = document.getElementById("charCount");

    intro.addEventListener("input", function () {
        charCount.textContent = intro.value.length;
    });
</script>

</body>
</html>