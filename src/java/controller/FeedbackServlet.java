package controller;

import DAO.FeedBackDAO;
import DAO.FilmDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;
import model.Film;

import java.io.IOException;
import java.util.List;

public class FeedbackServlet extends HttpServlet {

    private FeedBackDAO feedbackDAO = new FeedBackDAO(); // Initialize the DAO
    private FilmDao filmDAO = new FilmDao(); // Initialize the DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String filmIdParam = request.getParameter("filmid");

        // Validate the filmId parameter
        if (filmIdParam == null || filmIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Film ID is required.");
            return;
        }

        try {
            int filmId = Integer.parseInt(filmIdParam);

            // Retrieve the film and feedback information
            Film film = filmDAO.getFilmByID(filmId);
            if (film == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Film not found.");
                return;
            }

            List<Feedback> feedbackList = feedbackDAO.getFeedbackByFilmId(filmId, "DESC"); // Sort feedback by rating

            // Set attributes for feedback.jsp
            request.setAttribute("film", film);
            request.setAttribute("feedbackList", feedbackList);

            // Forward the request to feedback.jsp
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Handle invalid filmId parameter
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid film ID format.");
        } catch (Exception e) {
            // Handle general errors
            throw new ServletException("Error retrieving film feedback", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int filmId = Integer.parseInt(request.getParameter("filmid"));
        String comment = request.getParameter("comment");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        // Lấy userId từ session hoặc từ thông tin hiện tại của người dùng
        int userId = (int) request.getSession().getAttribute("userId");  // Giả sử userId đã được lưu trong session

        // Lưu feedback vào cơ sở dữ liệu
        feedbackDAO.submitFeedback(filmId, userId, comment, rating);

        // Chuyển hướng về lại trang film.jsp với thông tin mới
        response.sendRedirect("film.jsp?filmid=" + filmId);
    }

    @Override
    public String getServletInfo() {
        return "Servlet that retrieves and displays feedback for a specific film.";
    }
}
