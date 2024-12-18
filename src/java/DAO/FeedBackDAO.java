package DAO;

import model.User;
import model.Feedback;
import model.Film;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedBackDAO {

    private static final Logger logger = Logger.getLogger(FeedBackDAO.class.getName());

    private FilmDao filmDAO = new FilmDao(); // Ensure FilmDao is initialized
    private UserDao userDao = new UserDao(); // Ensure UserDao is initialized

    // Phương thức lấy danh sách phản hồi theo FilmID
    public List<Feedback> getFeedbackByFilmId(int filmId, String sort) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sortOrder = "DESC"; // Mặc định sắp xếp giảm dần

        // Kiểm tra nếu 'low' được truyền vào để sắp xếp tăng dần
        if ("low".equalsIgnoreCase(sort)) {
            sortOrder = "ASC"; // Sắp xếp tăng dần nếu "low" được chỉ định
        }

        // Câu truy vấn SQL để lấy phản hồi cho FilmID nhất định, sắp xếp theo rating
        String query = "SELECT * FROM Feedback WHERE FilmID = ? ORDER BY rating " + sortOrder;

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            // Thiết lập tham số FilmID
            ps.setInt(1, filmId);

            try (ResultSet rs = ps.executeQuery()) {
                // Xử lý kết quả truy vấn và chuyển dữ liệu thành đối tượng Feedback
                while (rs.next()) {
                    // Tạo đối tượng User từ kết quả truy vấn
                    User user = userDao.findUser(rs.getInt("user_id"));

                    // Tạo đối tượng Film từ FilmID
                    Film film = filmDAO.getFilmByID(filmId);

                    // Tạo đối tượng Feedback và thêm vào danh sách
                    Feedback feedback = new Feedback(
                            user,        // User đã đánh giá
                            film,        // Film mà feedback liên quan
                            rs.getString("comment"),  // Comment của feedback
                            rs.getInt("rating"),      // Rating của feedback
                            rs.getDate("feedback_date")  // Ngày đánh giá
                    );
                    feedbackList.add(feedback);
                }
            }

        } catch (SQLException e) {
            // Ghi lại lỗi thay vì in stack trace
            logger.log(Level.SEVERE, "Error retrieving feedback for film ID: " + filmId, e);
        }

        return feedbackList;
    }

    // Phương thức lưu phản hồi vào cơ sở dữ liệu
    public void submitFeedback(int filmId, int userId, String comment, int rating) {
        String query = "INSERT INTO Feedback (FilmID, UserID, Comment, Rating, feedback_date) VALUES (?, ?, ?, ?, NOW())";
        
        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
             
            // Thiết lập tham số cho câu truy vấn SQL
            ps.setInt(1, filmId);  // FilmID
            ps.setInt(2, userId);   // UserID
            ps.setString(3, comment);  // Comment
            ps.setInt(4, rating);  // Rating
            
            // Thực thi câu lệnh INSERT
            ps.executeUpdate(); 
            
        } catch (SQLException e) {
            // Ghi lại lỗi nếu có
            logger.log(Level.SEVERE, "Error submitting feedback for film ID: " + filmId, e);
        }
    }
}
