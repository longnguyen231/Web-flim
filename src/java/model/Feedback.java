package model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Feedback {

    private int feedbackId;
    private User userId;
    private Film filmId;
    private String comment;
    private int rating;
    private Date feedbackDate;

    // Constructors
    public Feedback() {
    }

    public Feedback(int feedbackId, User customerId, Film productId, String comment, int rating, Date feedbackDate) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.filmId = filmId;
        this.comment = comment;
        this.rating = rating;
        this.feedbackDate = feedbackDate;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Film getFilmId() {
        return filmId;
    }

    public void setFilmId(Film filmId) {
        this.filmId = filmId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

   
 public String getDobString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(this.feedbackDate);
    }
}
