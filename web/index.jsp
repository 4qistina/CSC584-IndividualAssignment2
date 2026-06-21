<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Information Form</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <link rel="stylesheet" href="CSS/indexCSS.css">

</head>
<body>

<div class="resume-wrap">

    <!-- Header -->
    <div class="form-header">
        <h1><i class="ti ti-user-plus" aria-hidden="true"></i> Personal Information</h1>
        <p>Please fill in your details below</p>
        <div class="divider"></div>
    </div>

    <!-- Form -->
    <form action="${pageContext.request.contextPath}/ProfileServlet" method="post" id="profileForm">
        <input type="hidden" name="action" value="insert">

        <!-- Full Name -->
        <div class="field-group">
            <label><i class="ti ti-user" aria-hidden="true"></i> Full Name</label>
            <input type="text" name="name" placeholder="Enter your full name" required>
        </div>

        <!-- Student ID + Programme -->
        <div class="two-col">
            <div class="field-group">
                <label><i class="ti ti-id-badge" aria-hidden="true"></i> Student ID</label>
                <input type="text" name="studentID" placeholder="2024xxxxxx" required>
            </div>

            <div class="field-group">
                <label><i class="ti ti-school" aria-hidden="true"></i> Programme</label>
                <input type="text" name="programme" placeholder="CS266" required>
            </div>
        </div>

        <!-- Email -->
        <div class="field-group">
            <label><i class="ti ti-mail" aria-hidden="true"></i> Email Address</label>
            <input type="email" name="email" placeholder="example@email.com" required>
        </div>

        <hr class="section-divider">

        <!-- Hobbies -->
        <div class="field-group">
            <label><i class="ti ti-heart" aria-hidden="true"></i> Hobbies</label>
            <input type="text" name="hobbies" placeholder="Reading, Gaming, Sports" required>
        </div>

        <hr class="section-divider">

        <!-- Self Introduction -->
        <div class="field-group">
            <label><i class="ti ti-file-text" aria-hidden="true"></i> Self Introduction</label>
            <textarea name="introduction"
                      rows="5"
                      placeholder="Tell us something about yourself..."
                      required></textarea>
        </div>

        <!-- Submit -->
        <button type="submit" class="submit-btn">
            <i class="ti ti-send" aria-hidden="true"></i>
            Submit Form
        </button>

    </form>

</div>

<script>
    const form = document.getElementById("profileForm");

    form.addEventListener("submit", function(event) {

        const name         = document.querySelector('input[name="name"]').value.trim();
        const studentID    = document.querySelector('input[name="studentID"]').value.trim();
        const programme    = document.querySelector('input[name="programme"]').value.trim();
        const email        = document.querySelector('input[name="email"]').value.trim();
        const hobbies      = document.querySelector('input[name="hobbies"]').value.trim();
        const introduction = document.querySelector('textarea[name="introduction"]').value.trim();

        // Full name validation
        if (name.length < 3) {
            alert("Full name must contain at least 3 characters.");
            event.preventDefault();
            return;
        }

        // Student ID validation
        const studentPattern = /^202\d+$/;
        if (!studentPattern.test(studentID)) {
            alert("Student ID must be in format 202xxxxxxx");
            event.preventDefault();
            return;
        }

        // Programme validation
        if (programme.length < 4) {
            alert("Please enter a valid programme code (eg: CS266).");
            event.preventDefault();
            return;
        }

        // Email validation
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            event.preventDefault();
            return;
        }

        // Hobbies validation
        if (hobbies.length < 3) {
            alert("Hobbies must contain at least 3 characters.");
            event.preventDefault();
            return;
        }

        // Introduction validation
        if (introduction.length < 5) {
            alert("Self introduction must contain at least 5 characters.");
            event.preventDefault();
            return;
        }

        // Confirmation popup
        const confirmSubmission = confirm(
            "Hi " + name + ", are you sure you want to submit your personal information?"
        );

        if (!confirmSubmission) {
            event.preventDefault();
            return;
        }

        alert("Form submitted successfully!");
    });
</script>

</body>
</html>