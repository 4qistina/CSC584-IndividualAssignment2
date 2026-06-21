package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProfileDAO;
import Model.ProfileBean;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProfileDAO dao = new ProfileDAO();

        String deleteId = request.getParameter("delete");
        String editId = request.getParameter("edit");
        String viewId = request.getParameter("view");

        // DELETE
        if (deleteId != null) {
            dao.deleteProfile(deleteId);
            response.sendRedirect("ProfileServlet");
            return;
        }

        // VIEW ONE
        if (viewId != null) {
            ProfileBean p = dao.getProfileByStudentID(viewId);

            request.setAttribute("profilebean", p);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // EDIT
        if (editId != null) {
            ProfileBean p = dao.getProfileByStudentID(editId);

            request.setAttribute("profilebean", p);
            request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            return;
        }

        // VIEW ALL (FIXED - ALWAYS LOAD DATA HERE)
        List<ProfileBean> list = dao.selectAllProfiles();

        System.out.println("Loaded profiles: " + list.size()); // DEBUG

        request.setAttribute("profileList", list);
        request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        ProfileDAO dao = new ProfileDAO();

        String studentID;
        String name;
        String programme;
        String email;
        String hobbies;
        String introduction;

        // INSERT
        if (action == null || action.equals("insert")) {

            studentID = request.getParameter("studentID");
            name = request.getParameter("name");
            programme = request.getParameter("programme");
            email = request.getParameter("email");
            hobbies = request.getParameter("hobbies");
            introduction = request.getParameter("introduction");

            ProfileBean profilebean = new ProfileBean(
                    studentID, name, programme, email, hobbies, introduction
            );

            dao.insertProfile(profilebean);

            request.setAttribute("profilebean", profilebean);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // UPDATE
        if (action.equals("update")) {

            studentID = request.getParameter("studentID");
            name = request.getParameter("name");
            programme = request.getParameter("programme");
            email = request.getParameter("email");
            hobbies = request.getParameter("hobbies");
            introduction = request.getParameter("introduction");

            ProfileBean profilebean = new ProfileBean(
                    studentID, name, programme, email, hobbies, introduction
            );

            dao.updateProfile(profilebean);

            response.sendRedirect(request.getContextPath() + "/ProfileServlet");
        }
    }

    @Override
    public String getServletInfo() {
        return "Profile Servlet";
    }
}
