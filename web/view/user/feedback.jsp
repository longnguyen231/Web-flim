<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Feedbacks List</title>
        <%@ include file="../component/header.jsp" %> <!-- Include header -->

        <script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- For star icons -->
    </head>

    <body>
        <div class="container mt-5">
            <div class="row">
                <!-- Customer Reviews -->
                <div class="col-lg-4 col-md-5 col-12 mb-4 mb-lg-0 pr-lg-6">
                    <h4 class="mb-3">Customer reviews</h4>
                    <span class="font-14">
                        <!-- Display rating stars -->
                        <c:forEach begin="1" end="5" var="i">
                            <i class="fa fa-star star-active mx-1" title="Rated ${i}"></i>
                        </c:forEach>
                    </span>
                    <h5>${averageRating}</h5>
                    <p class="font-14">${ratingCount} comments</p>

                    <!-- Rating Progress Bars -->
                    <div class="row align-items-center mb-1">
                        <div class="col-2 pr-0">
                            <div class="font-12 text-dark">5 Star</div>
                        </div>
                        <div class="col-8 pr-2">
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: ${fiveStarPercentage}%" aria-valuenow="${fiveStarPercentage}%" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="font-12 text-primary">${fiveStarPercentage}%</div>
                        </div>
                    </div>
                    <!-- More rating progress bars for 4, 3, 2, 1 stars -->
                </div>

                <!-- Customer Reviews List -->
                <div class="col-lg-8 col-md-7 col-12">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h4 class="mb-0">Ratings & Reviews</h4>
                        <form method="GET" action="feedback">
                            <input type="hidden" value="${product.getProductId()}" name="productid">
                            <label for="sortOptions">Sort by:</label>
                            <select id="sortOptions" name="sortRating" class="custom-select" onchange="this.form.submit()">
                                <option value="DESC" ${param.sortRating == 'DESC' ? 'selected' : ''}>Rating: High to Low</option>
                                <option value="low" ${param.sortRating == 'low' ? 'selected' : ''}>Rating: Low to High</option>
                            </select>
                        </form>
                    </div>

                    <!-- Reviews -->
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="mb-4 pb-4 border-bottom">
                            <div class="d-flex mb-3 align-items-center">
                                <img src="path_to_images/avatar-1.png" alt="" class="rounded-circle avatar-lg">
                                <div class="ml-2">
                                    <h5 class="mb-1">${feedback.customerId.customerName}</h5>
                                    <p class="font-12 mb-0"><span>${feedback.dobString}</span></p>
                                </div>
                            </div>
                            <div class="mb-2 star-rating">
                                <span class="font-14 mr-2">
                                    <c:forEach begin="1" end="${feedback.rating}" var="i">
                                        <i class="fa fa-star star-active mx-1" title="Rated ${i}"></i>
                                    </c:forEach>
                                    <c:forEach begin="${feedback.rating + 1}" end="5" var="j">
                                        <i class="fa fa-star star-inactive mx-1" title="Rated ${j}"></i>
                                    </c:forEach>
                                </span>
                            </div>
                            <p>${feedback.comment}</p>
                            <c:if test="${hasPurchased}">
                                <button style="margin-top: 20px" class="btn btn-primary btn-block" data-toggle="modal" data-target="#reviewModal" 
                                        data-feedback-id="${feedback.feedbackId}" data-feedback-comment="${feedback.comment}" 
                                        data-feedback-rating="${feedback.rating}">
                                    Edit
                                </button>
                            </c:if>
                        </div>
                    </c:forEach>

                    <!-- Review Modal -->
                    <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="reviewModalLabel">Edit Your Review</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="feedbackForm" action="feedback" method="POST">
                                        <input type="hidden" id="feedbackId" name="feedbackId">
                                        <input type="hidden" value="${product.getProductId()}" name="productid">
                                        <div class="form-group">
                                            <label for="customerName">Your Name</label>
                                            <input value="${account.getCustomerName()}" type="text" class="form-control" id="customerName" required readonly>
                                        </div>
                                        <div class="form-group">
                                            <label for="rating">Rate:</label>
                                            <select class="form-control" id="rating" name="rating" required>
                                                <option value="">Select Rating</option>
                                                <option value="1">1 Star</option>
                                                <option value="2">2 Stars</option>
                                                <option value="3">3 Stars</option>
                                                <option value="4">4 Stars</option>
                                                <option value="5">5 Stars</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="feedbackComment">Comment</label>
                                            <textarea class="form-control" id="feedbackComment" name="feedbackComment" rows="4" required></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../component/footer.jsp" %> <!-- Include footer -->
    </body>
</html>
