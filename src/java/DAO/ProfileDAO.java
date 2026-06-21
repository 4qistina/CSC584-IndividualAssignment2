package DAO;

import Model.ProfileBean;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfileDAO {

    // Derby Database Connection
    private final String jdbcURL = "jdbc:derby://localhost:1527/StudentProfilesDB";
    private final String jdbcUsername = "app";
    private final String jdbcPassword = "app";

    // DATABASE CONNECTION
    protected Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            conn = DriverManager.getConnection(
                    jdbcURL,
                    jdbcUsername,
                    jdbcPassword
            );

            System.out.println("Database connected successfully!");

        } catch (ClassNotFoundException e) {
            System.out.println("Derby Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
        }

        return conn;
    }

    // INSERT PROFILE
    public void insertProfile(ProfileBean profilebean) {
        String sql = "INSERT INTO PROFILE " +
                     "(STUDENTID, NAME, PROGRAMME, EMAIL, HOBBIES, INTRODUCTION) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, profilebean.getStudentID());
            ps.setString(2, profilebean.getName());
            ps.setString(3, profilebean.getProgramme());
            ps.setString(4, profilebean.getEmail());
            ps.setString(5, profilebean.getHobbies());
            ps.setString(6, profilebean.getIntroduction());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // SELECT ALL PROFILES
    public List<ProfileBean> selectAllProfiles() {

        List<ProfileBean> list = new ArrayList<>();

        String sql = "SELECT STUDENTID, NAME, PROGRAMME, EMAIL, HOBBIES, INTRODUCTION FROM PROFILE";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                ProfileBean profilebean = new ProfileBean();

                profilebean.setStudentID(rs.getString("STUDENTID"));
                profilebean.setName(rs.getString("NAME"));
                profilebean.setProgramme(rs.getString("PROGRAMME"));
                profilebean.setEmail(rs.getString("EMAIL"));
                profilebean.setHobbies(rs.getString("HOBBIES"));
                profilebean.setIntroduction(rs.getString("INTRODUCTION"));

                list.add(profilebean);
            }

        } catch (SQLException e) {
            System.out.println("ERROR fetching profiles");
            e.printStackTrace();
        }

        return list;
    }

    // UPDATE PROFILE
    public void updateProfile(ProfileBean profilebean) {
        String sql = "UPDATE PROFILE SET " +
                     "NAME=?, PROGRAMME=?, EMAIL=?, HOBBIES=?, INTRODUCTION=? " +
                     "WHERE STUDENTID=?";

        try (
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, profilebean.getName());
            ps.setString(2, profilebean.getProgramme());
            ps.setString(3, profilebean.getEmail());
            ps.setString(4, profilebean.getHobbies());
            ps.setString(5, profilebean.getIntroduction());
            ps.setString(6, profilebean.getStudentID());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // DELETE PROFILE
    public void deleteProfile(String studentID) {
        String sql = "DELETE FROM PROFILE WHERE STUDENTID=?";

        try (
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, studentID);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // GET PROFILE BY STUDENT ID
    public ProfileBean getProfileByStudentID(String studentID) {
        ProfileBean profilebean = null;
        String sql = "SELECT * FROM PROFILE WHERE STUDENTID=?";

        try (
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, studentID);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    profilebean = new ProfileBean();

                    profilebean.setStudentID(rs.getString("STUDENTID"));
                    profilebean.setName(rs.getString("NAME"));
                    profilebean.setProgramme(rs.getString("PROGRAMME"));
                    profilebean.setEmail(rs.getString("EMAIL"));
                    profilebean.setHobbies(rs.getString("HOBBIES"));
                    profilebean.setIntroduction(rs.getString("INTRODUCTION"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profilebean;
    }
}
