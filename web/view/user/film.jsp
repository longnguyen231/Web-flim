<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../component/setupCss.jsp" %>
    </head>
    <body>
        <!--Header-->
        <%@include file="../component/header.jsp" %>
        <!--Header-->

        <!-- Film section -->
        <section class="bg-light">
            <div class="container pb-5">
                <div class="row">
                    <div class="col-lg-5 mt-5">
                        <div class="card mb-3">
                            <a href="https://www.youtube.com/watch?v=4P0R9dUJ370">
                                <img class="card-img img-fluid" 
                                     src="view/images/${requestScope.film.image}" alt="Card image cap"
                                     style="height: 700px; width: auto"
                                     id="product-detail">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7 mt-5">
                        <div class="card" style="height: 700px">
                            <div class="card-body">
                                <h1 class="h2">${requestScope.film.title}</h1>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <h6>Genres:</h6>
                                    </li>
                                    <li class="list-inline-item">
                                        <p class="text-muted">
                                            <strong>${requestScope.film.genres.name}</strong>
                                        </p>
                                    </li>
                                </ul>

                                <h6>Description:</h6>
                                <p>${requestScope.film.description}</p>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                        <h6>Author:</h6>
                                    </li>
                                    <li class="list-inline-item">
                                        <p class="text-muted"><strong>${requestScope.film.author}</strong></p>
                                    </li>
                                </ul>

                                <ul class="list-inline d-flex">
                                    <li class="list-inline-item">
                                        <h6>Casts:</h6>
                                    </li>
                                    <li class="list-inline-item">
                                        <p class="text-muted">
                                            <strong>${requestScope.film.actor} </strong>
                                        </p>
                                    </li>
                                </ul>

                                <h6>Movie duration: ${requestScope.film.time} minutes</h6>
                                <h6 class="mt-4">Language: ${requestScope.film.country.countryName}</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Feedback Section -->
        <section class="feedback-section">
            <div class="container">
                <h3>Feedback for ${requestScope.film.title}</h3>

                <!-- Iterate through feedbacks -->
                <c:forEach var="feedback" items="${requestScope.feedbackList}">
                    <div class="feedback-item d-flex mt-4">
                        <img src="img/avatar.jpg" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="User Avatar">
                        <div class="ml-3">
                            <p class="mb-2" style="font-size: 14px;">${feedback.feedbackDateString}</p>
                            <div class="d-flex justify-content-between">
                                <h5>${feedback.userId.name}</h5>
                                <div class="d-flex mb-3">
                                    <!-- Render stars based on feedback rating -->
                                    <c:forEach var="i" begin="1" end="${feedback.rating}">
                                        <i class="fa fa-star text-secondary"></i>
                                    </c:forEach>
                                    <c:forEach var="i" begin="${feedback.rating+1}" end="5">
                                        <i class="fa fa-star text-muted"></i>
                                    </c:forEach>
                                </div>
                            </div>
                            <p>${feedback.comment}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Open Modal Button for Feedback -->
        <button type="button" class="btn btn-outline-primary btn-lg rounded-pill px-5 py-3 transition-all hover-shadow-lg" data-bs-toggle="modal" data-bs-target="#feedbackModal">
            <i class="bi bi-chat-left-dots"></i> Leave a Feedback
        </button>

        <!-- Modal for Feedback -->
        <div class="modal fade" id="feedbackModal" tabindex="-1" aria-labelledby="feedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="feedbackModalLabel">Leave a Feedback</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="feedback?filmid=${requestScope.film.filmId}">
                            <div class="mb-3">
                                <label for="comment" class="form-label">Your Comment</label>
                                <textarea class="form-control" id="comment" name="comment" rows="4" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="rating" class="form-label">Rating</label>
                                <select class="form-select" id="rating" name="rating" required>
                                    <option value="1">1 Star</option>
                                    <option value="2">2 Stars</option>
                                    <option value="3">3 Stars</option>
                                    <option value="4">4 Stars</option>
                                    <option value="5">5 Stars</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Submit Feedback</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--Footer-->
        <%@include file="../component/footer.jsp"%>
        <!--Footer-->
    </body>
</html>
